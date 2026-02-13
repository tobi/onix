# onix

Hermetic Ruby packages from `Gemfile.lock`. Import a lockfile, build every gem once, cache forever.

```
$ onix import ~/src/rails     # parse Gemfile.lock → packagesets/rails.jsonl
$ onix generate               # prefetch hashes, write nix derivations
$ onix build                  # build everything
```

## Why

Bundler solves dependency resolution but not hermetic builds. Nix solves hermetic builds but doesn't understand lockfiles. onix bridges them:

- **Lockfile in, nix derivations out.** Your existing `Gemfile.lock` becomes the source of truth.
- **System libraries only.** Native extensions link against nixpkgs — no vendored copies of openssl, libxml2, sqlite, etc.
- **One derivation per gem.** Individually cacheable, parallel builds, content-addressed store paths.
- **Build once, cache forever.** Same lockfile + same nixpkgs = same store paths. CI and dev share the cache.

## Install

```bash
gem install https://github.com/tobi/onix
```

Requires Ruby ≥ 3.1 and [Nix](https://nixos.org/download/).

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
onix import --name blog Gemfile.lock # explicit name
```

Parses the lockfile and writes a hermetic JSONL packageset to `packagesets/<name>.jsonl`. For git-sourced gems, clones the repo to discover monorepo subdirectories.

### 3. Generate nix derivations

```bash
onix generate        # default: 20 parallel prefetch jobs
onix generate -j 8   # fewer jobs
```

Prefetches SHA256 hashes for all gems via `nix-prefetch-url` and `nix-prefetch-git`, then writes:
- `nix/ruby/<name>.nix` — one file per gem with all versions and hashes
- `nix/<project>.nix` — per-project gem selection, bundlePath, and devShell
- `nix/build-gem.nix` — wrapper around nixpkgs `buildRubyGem`
- `nix/gem-config.nix` — overlay loader

### 4. Build

```bash
onix build                    # build all projects
onix build myapp              # build all gems for one project
onix build myapp nokogiri     # build a single gem
onix build -k                 # keep going past failures
```

Pipes through [nix-output-monitor](https://github.com/maralorn/nix-output-monitor) when available. On failure, tells you exactly what to do:

```
  ✗ sqlite3  →  create overlays/sqlite3.nix
    nix log /nix/store/...-sqlite3-2.8.0.drv
```

### 5. Check

```bash
onix check
```

Runs `nix-eval`, `packageset-complete`, and `secrets` checks in parallel.

## Using built packages

Each project nix file exports individual gems, a merged `bundlePath`, and a `devShell`:

### devShell (recommended)

```nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  project = import ./nix/rails.nix { inherit pkgs ruby; };
in project.devShell {
  buildInputs = with pkgs; [ sqlite postgresql ];
}
```

Sets `BUNDLE_PATH`, `BUNDLE_GEMFILE`, and `GEM_PATH` automatically. Ruby can `require` any gem in the bundle without `bundler/setup`.

### bundlePath

For CI scripts, Docker images, or custom derivations:

```nix
project.bundlePath   # → /nix/store/...-rails-bundle
                     # contains gems/*, specifications/*, extensions/*
```

## Overlays

When a gem needs system libraries or custom build steps, create `overlays/<gem-name>.nix`.

### System library deps

```nix
# overlays/pg.nix
{ pkgs, ruby, ... }: with pkgs; [ libpq pkg-config ]
```

### Use system libraries instead of vendored copies

```nix
# overlays/sqlite3.nix
{ pkgs, ruby, ... }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

### Build-time gem dependencies

Some gems need other gems during `extconf.rb`. Use `buildGems` with the `buildGem` function:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby, buildGem, ... }: {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (buildGem "mini_portile2")
  ];
}
```

### Rust extensions

```nix
# overlays/tiktoken_ruby.nix
{ pkgs, ruby, buildGem, ... }: {
  deps = with pkgs; [ rustc cargo libclang ];
  buildGems = [ (buildGem "rb_sys") ];
  preBuild = ''
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
  '';
}
```

### All overlay fields

| Field | Type | Effect |
|-------|------|--------|
| `deps` | list | Added to `nativeBuildInputs` |
| `extconfFlags` | string | Appended to `ruby extconf.rb` |
| `buildGems` | list | Gems needed at build time (`GEM_PATH` set automatically) |
| `preBuild` | string | Runs before the build phase |
| `postBuild` | string | Runs after the build phase |
| `buildPhase` | string | **Replaces** the default build entirely |
| `postInstall` | string | Runs after install |

### Skip a gem

```nix
# overlays/therubyracer.nix — abandoned, use mini_racer
{ pkgs, ruby, ... }: { buildPhase = "true"; }
```

## Directory structure

```
my-packages/
├── packagesets/       # JSONL packagesets (one per project)
│   ├── rails.jsonl
│   └── liquid.jsonl
├── overlays/          # Hand-written build overrides
│   ├── nokogiri.nix
│   └── sqlite3.nix
└── nix/               # Generated — never edit
    ├── ruby/          # Per-gem derivations
    ├── rails.nix      # Per-project entry point
    ├── build-gem.nix
    └── gem-config.nix
```

## Design

- **Nix-native fetch.** `generate` prefetches hashes; `build` uses `fetchurl`/`builtins.fetchGit`. No local cache.
- **System libraries only.** Native extensions link against nixpkgs. Vendored copies are replaced.
- **Lockfile is truth.** Packagesets are hermetic JSONL parsed once during import.
- **One derivation per gem.** Individually cacheable, parallel, content-addressed.
- **Overlays win.** Manual overrides always take precedence over auto-detection.
- **Parameterized runtime.** `ruby` flows through every derivation — one argument changes the whole build.
