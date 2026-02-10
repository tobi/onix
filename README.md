# onix

Hermetic Nix packages from language-specific lockfiles. Import a lockfile, build every package once, cache forever.

Currently supports **Ruby** (Gemfile.lock). **npm** (package-lock.json) is planned.

```
$ onix import ~/src/rails     # parse Gemfile.lock → packagesets/rails.jsonl
$ onix import ~/src/shopify   # import as many projects as you want
$ onix generate               # prefetch hashes, write nix derivations
$ onix build                  # build everything, cache forever
```

## Why

Language package managers (Bundler, npm, pip) solve dependency resolution but not hermetic builds. Nix solves hermetic builds but doesn't understand lockfiles. onix bridges them:

- **Lockfile in, nix derivations out.** Your existing `Gemfile.lock` (or soon `package-lock.json`) becomes the source of truth.
- **System libraries only.** Native extensions link against nixpkgs. No vendored copies of openssl, libxml2, sqlite, etc.
- **One derivation per package.** Individually cacheable, parallel builds, content-addressed store paths.
- **Build once, cache forever.** Same lockfile + same nixpkgs = same store paths. CI and dev machines share the cache.

## Install

```bash
gem install specific_install
gem specific_install https://github.com/tobi/onix
```

Requires Ruby >= 3.1 and Nix.

## Workflow

### 1. Initialize a project

```bash
mkdir my-packages && cd my-packages
onix init
```

Creates the directory structure: `packagesets/`, `overlays/`, `nix/ruby/`.

### 2. Import a lockfile

```bash
onix import ~/src/myapp              # reads myapp/Gemfile.lock
onix import --name blog Gemfile.lock  # explicit name
```

Parses the lockfile and writes a hermetic JSONL packageset to `packagesets/<name>.jsonl`. For git-sourced gems, clones the repo to discover monorepo subdirectories. Everything after import is mechanical.

### 3. Generate nix derivations

```bash
onix generate        # default: 20 parallel prefetch jobs
onix generate -j 8   # fewer jobs
```

Prefetches SHA256 hashes for all gems via `nix-prefetch-url` and `nix-prefetch-git`, then writes:
- `nix/ruby/<name>.nix` — per gem, all versions with hashes
- `nix/<project>.nix` — per project, gem selection + bundlePath + devShell
- `nix/build-gem.nix` — generic builder
- `nix/gem-config.nix` — overlay loader

### 4. Build

```bash
onix build                    # build every package in the pool
onix build myapp              # build all packages for one app
onix build myapp nokogiri     # build a single package from an app
onix build -k                 # keep going past failures
```

Shows live progress during builds (pipes through [nix-output-monitor](https://github.com/maralorn/nix-output-monitor) if available). On failure, prints the package name, the derivation path, and whether to create or edit an overlay:

```
  ✗ sqlite3  →  create overlays/sqlite3.nix
    nix log /nix/store/...-sqlite3-2.8.0.drv
```

### 5. Check

```bash
onix check                            # all checks
onix check nix-eval packageset-complete  # specific ones
```

Checks: `nix-eval` · `packageset-complete` · `secrets`. All run in parallel, results stream as they complete.

## Using built packages

Each project nix file exports gems, bundlePath, and devShell:

| Key | Type | Description |
|-----|------|-------------|
| `<gem-name>` | derivation | Individual package outputs |
| `bundlePath` | derivation | All packages merged into a single `BUNDLE_PATH` via `buildEnv` |
| `devShell` | function | `mkShell` wrapper that sets `BUNDLE_PATH`, `BUNDLE_GEMFILE`, and includes `ruby` |

### devShell (recommended)

The simplest way to use onix. Handles all plumbing automatically:

```nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  project = import ./nix/rails.nix { inherit pkgs ruby; };
in project.devShell {
  buildInputs = with pkgs; [ sqlite postgresql ];
}
```

### bundlePath

For CI scripts, Docker images, or custom derivations:

```nix
project.bundlePath   # → /nix/store/...-rails-bundle
                     # contains gems/*, specifications/*, extensions/*
```

## Overlays

When a gem needs system libraries or custom build steps, create `overlays/<gem-name>.nix`. **Manual overlays always win** over auto-detection.

### System library deps

```nix
# overlays/pg.nix
{ pkgs, ruby }: with pkgs; [ libpq pkg-config ]
```

### System library flags

Force packages to use system libraries instead of vendored copies:

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

### Build-time dependencies

Some packages need other packages during build. Use `buildGems` — the framework constructs `GEM_PATH` automatically:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [ "mini_portile2" ];
}
```

### Lifecycle hooks

| Field | Type | Effect |
|-------|------|--------|
| `deps` | list | Added to `nativeBuildInputs` |
| `extconfFlags` | string | Appended to `ruby extconf.rb` |
| `buildGems` | list | Gem names needed at build time (auto `GEM_PATH`) |
| `beforeBuild` | string | Runs before the default build phase |
| `afterBuild` | string | Runs after `make` |
| `buildPhase` | string | **Replaces** the default build entirely |
| `postInstall` | string | Runs after install (`$dest` available) |

### Skip a package

```nix
# overlays/therubyracer.nix — abandoned
{ pkgs, ruby }: { buildPhase = "true"; }
```

## Packageset format

Packagesets live in `packagesets/` as JSONL files (one JSON object per line). First line is metadata, remaining lines are one entry per gem.

```jsonl
{"_meta":true,"ruby":"3.4.8","bundler":"2.6.5","platforms":["arm64-darwin","ruby"]}
{"installer":"ruby","name":"rack","version":"3.1.12","source":"rubygems","remote":"https://rubygems.org","deps":["webrick"]}
{"installer":"ruby","name":"rails","version":"8.0.0","source":"git","uri":"https://github.com/rails/rails.git","rev":"abc123...","subdir":"railties"}
```

See `docs/packageset-format.md` for the full specification.

## Directory structure

```
my-packages/
├── packagesets/      # Hermetic JSONL packagesets (one per project)
│   ├── rails.jsonl
│   └── liquid.jsonl
├── overlays/         # Hand-written build overrides
└── nix/              # Generated — never edit by hand
    ├── ruby/         # Per-gem version files (rack.nix, nokogiri.nix, ...)
    ├── rails.nix     # Per-project gem selection
    ├── build-gem.nix     # Generic builder
    └── gem-config.nix    # Overlay loader
```

## Design principles

- **Nix-native fetch.** `generate` prefetches hashes, then `build` uses `fetchurl`/`builtins.fetchGit` — no local cache directory needed.
- **System libraries only.** Native packages link against nixpkgs. Vendored copies are stripped.
- **Lockfile is the source of truth.** Packagesets are hermetic JSONL representations of your lockfile, parsed once during import.
- **One derivation per package.** Individually cacheable, parallel builds, content-addressed store paths.
- **Manual overlays always win** over auto-detection.
- **Parameterized runtime.** `ruby` (or `nodejs`) flows through every derivation — one argument changes the whole build.
- **Ecosystem-agnostic core.** The overlay system, nix output layout, and build/check commands work across ecosystems. Only the parser and materializer are ecosystem-specific.
