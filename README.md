# onix

Hermetic Ruby and pnpm packages from `Gemfile.lock` / `pnpm-lock.yaml`. Import a lockfile, generate deterministic Nix derivations, and build once for cache reuse.

```
$ onix import ~/src/rails     # parse Gemfile.lock → packagesets/rails.jsonl
$ onix generate               # prefetch hashes, write nix derivations
$ onix build                  # build everything
```

## Why

Bundler solves dependency resolution but not hermetic builds. Nix solves hermetic builds but doesn't understand lockfiles. onix bridges them:

- **Lockfile in, nix derivations out.** Your existing `Gemfile.lock` becomes the source of truth.
- **System libraries only.** Native extensions link against nixpkgs — no vendored copies of openssl, libxml2, sqlite, etc.
- **One derivation per package family.** Ruby gems and node_modules builds are individually cacheable and content-addressed.
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
onix import --installer pnpm ~/src/my-app # reads myapp/pnpm-lock.yaml
onix import --name blog Gemfile.lock # explicit name
```

Parses the lockfile and writes a hermetic JSONL packageset to `packagesets/<name>.jsonl`.
For pnpm projects, entries are marked with `installer: "node"` and consumed by a separate node derivation pipeline.

### 3. Generate nix derivations

```bash
onix generate        # default: 20 parallel prefetch jobs
onix generate -j 8   # fewer jobs
onix generate --scripts none|allowed   # pnpm lifecycle control (default: none if no allowlist metadata)
```

Prefetches hashes for Ruby deps via `nix-prefetch-url`/`nix-prefetch-git`, then writes:
- `nix/ruby/<name>.nix` — one file per gem with all versions and hashes
- `nix/node/<name>.nix` — one file per node package/version set
- `nix/<project>.nix` — per-project gem selection, bundlePath, and devShell
- `nix/build-gem.nix` — wrapper around nixpkgs `buildRubyGem`
- `nix/build-node-modules.nix` — materializes `node_modules` with offline pnpm install
- `nix/gem-config.nix` — overlay loader
- `nix/node-config.nix` — node overlay loader

### 4. Build

```bash
onix build                    # build all projects
onix build myapp              # build all gems for one project
onix build myapp nokogiri     # build a single gem
onix build myapp node         # build node_modules derivation for the project
onix build -k                 # keep going past failures
```

`onix build` does not mutate workspace checkouts. It only builds Nix derivations.

Hydrate explicitly when you want a mutable `node_modules` in a target workspace:

```bash
onix hydrate myapp /path/to/workspace
# or default to lockfile directory from metadata:
onix hydrate myapp
```

Hydration stores a fast-path marker at `TARGET/.onix_node_modules_id`.

Pipes through [nix-output-monitor](https://github.com/maralorn/nix-output-monitor) when available. On failure, tells you exactly what to do:

```
  ✗ sqlite3  →  create overlays/sqlite3.nix
    nix log /nix/store/...-sqlite3-2.8.0.drv
```

### 5. Check

```bash
onix check
onix backfill
```

Runs `nix-eval`, `packageset-complete`, and `secrets` checks in parallel.

### 6. pnpm Pilot (Vite)

Use this as a concrete phase-1 validation path:

```bash
export ONIX_PILOT_PATH=/Users/vsumner/src/github.com/vitejs/vite
cd "$ONIX_PILOT_PATH"

# one-time setup (from the index repo)
onix import .
onix generate
onix build vite node
onix hydrate vite "$ONIX_PILOT_PATH"
```

Hydration repeatability check:

```bash
rm -rf node_modules .onix_node_modules_id
time onix hydrate vite "$ONIX_PILOT_PATH"

# second pass should be a fast no-op when derived path is unchanged
time onix hydrate vite "$ONIX_PILOT_PATH"
```

Expected:

- `node_modules` exists in workspace with `node_modules/.pnpm` populated.
- `.onix_node_modules_id` in the target workspace contains the source store path.
- second run should emit `node_modules unchanged` and avoid re-copying files.

Use the helper script (creates markdown-friendly timing output):

```bash
scripts/pilot-pnpm-onix.sh "$ONIX_PILOT_PATH"
```

### 8. Script policy controls

- `onix generate --scripts allowed` — keep existing workspace allowlist behavior.
- `onix generate --scripts none` — skip lifecycle scripts (`--ignore-scripts` equivalent).
- Any other value (including legacy `all`) is rejected so behavior remains explicit and deterministic.

### 7. Automated pilot script

`scripts/pilot-pnpm-onix.sh` performs:

- lockfile and git preflight checks,
- import/generate/build,
- first hydration timing,
- second no-op hydration timing,
- `.onix_node_modules_id` delta check,
- minimal secret-surface scan.

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
    ├── build-node-modules.nix
    ├── node-config.nix
    ├── node/          # Per-node package metadata
    └── gem-config.nix
```

## Design

- **Nix-native fetch.** `generate` prefetches hashes; `build` uses `fetchurl`/`builtins.fetchGit`. No local cache.
- **System libraries only.** Native extensions link against nixpkgs. Vendored copies are replaced.
- **Lockfile is truth.** Packagesets are hermetic JSONL parsed once during import.
- **One derivation per package set.** Ruby gems and project-level node_modules are cached separately and re-used across builds.
- **Overlays win.** Manual overrides always take precedence over auto-detection.
- **Parameterized runtime.** `ruby` flows through every derivation — one argument changes the whole build.
