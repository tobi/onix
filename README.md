# onix

Hermetic packages from lockfiles. Import a lockfile, build every package once, cache forever.

```
# Ruby
$ onix import ~/src/rails            # parse Gemfile.lock → packagesets/rails.jsonl
$ onix generate                      # prefetch hashes, write nix derivations
$ onix build                         # build everything

# Node (pnpm)
$ onix import-pnpm ~/src/myapp       # parse pnpm-lock.yaml → packagesets/myapp.jsonl
$ onix generate                      # prefetch hashes, write nix derivations
$ onix build                         # build everything
```

## Why

Package managers solve dependency resolution but not hermetic builds. Nix solves hermetic builds but doesn't understand lockfiles. onix bridges them:

- **Lockfile in, nix derivations out.** Your existing `Gemfile.lock` or `pnpm-lock.yaml` becomes the source of truth.
- **System libraries only.** Native extensions link against nixpkgs — no vendored copies of openssl, libxml2, sqlite, etc.
- **One derivation per package.** Individually cacheable, parallel builds, content-addressed store paths.
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

Creates the directory structure: `packagesets/`, `overlays/`, `nix/`.

### 2. Import a lockfile

```bash
# Ruby
onix import ~/src/myapp              # reads myapp/Gemfile.lock
onix import --name blog Gemfile.lock  # explicit name

# Node (pnpm)
onix import-pnpm ~/src/myapp         # reads myapp/pnpm-lock.yaml
onix import-pnpm --name blog path/to/pnpm-lock.yaml
```

Parses the lockfile and writes a hermetic JSONL packageset to `packagesets/<name>.jsonl`.

### 3. Generate nix derivations

```bash
onix generate        # default: 20 parallel prefetch jobs
onix generate -j 8   # fewer jobs
```

Prefetches SHA256 hashes via `nix-prefetch-url` and `nix-prefetch-git`, then writes:

**Ruby projects:**
- `nix/ruby/<name>.nix` — one file per gem with all versions and hashes
- `nix/<project>.nix` — per-project gem selection, bundlePath, and devShell
- `nix/build-gem.nix`, `nix/gem-config.nix`

**Node projects:**
- `nix/node/<name>.nix` — one file per npm package with all versions and hashes
- `nix/<project>.nix` — per-project package selection and packageDir
- `nix/build-npm.nix`, `nix/npm-config.nix`, `nix/pnpmfile.cjs`

Ruby and Node packagesets can coexist — `generate` processes both in one pass.
- `nix/build-gem.nix` — wrapper around nixpkgs `buildRubyGem`
- `nix/gem-config.nix` — overlay loader

### 4. Build

```bash
onix build                    # build all projects
onix build myapp              # build all packages for one project
onix build myapp nokogiri     # build a single package
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

### Ruby — devShell

```nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  project = import ./nix/rails.nix { inherit pkgs ruby; };
in project.devShell {
  buildInputs = with pkgs; [ sqlite postgresql ];
}
```

Sets `BUNDLE_PATH`, `BUNDLE_GEMFILE`, and `GEM_PATH` automatically.

### Ruby — bundlePath

```nix
project.bundlePath   # → /nix/store/...-rails-bundle
```

### Node — packageDir + pnpm install

```nix
{ pkgs ? import <nixpkgs> {}, nodejs ? pkgs.nodejs_22 }:
let
  project = import ./nix/myapp.nix { inherit pkgs nodejs; };
in project.packageDir   # → /nix/store/...-myapp-packages
                        # symlinks: express@4.21.2 → /nix/store/...-express-4.21.2/
```

The `packageDir` collects symlinks to all individually-built packages. To get a working `node_modules/`, use pnpm with the custom fetcher:

```bash
pkg_dir=$(nix-build nix/myapp.nix -A packageDir --no-out-link)
ONIX_PACKAGE_DIR="$pkg_dir" pnpm install --frozen-lockfile --ignore-scripts \
  --config.global-pnpmfile=nix/pnpmfile.cjs
```

pnpm reads packages from the Nix store (via the custom fetcher) instead of downloading tarballs, then materializes a standard `node_modules/` with its virtual store layout, dependency symlinks, and bin entries. Requires pnpm >= 10.

## Overlays

When a package needs system libraries or custom build steps, create `overlays/<name>.nix`.

### Ruby overlays

```nix
# overlays/pg.nix
{ pkgs, ruby, ... }: with pkgs; [ libpq pkg-config ]

# overlays/nokogiri.nix
{ pkgs, ruby, buildGem, ... }: {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [ (buildGem "mini_portile2") ];
}
```

### Node overlays

```nix
# overlays/better-sqlite3.nix
{ pkgs, nodejs, ... }: {
  deps = with pkgs; [ sqlite pkg-config python3 ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ darwin.cctools ];
  buildFlags = "--build-from-source";
}
```

### All overlay fields

**Ruby:** `deps`, `extconfFlags`, `buildGems`, `beforeBuild`, `afterBuild`, `buildPhase`, `postInstall`

**Node:** `deps`, `buildFlags`, `buildPackages`, `beforeBuild`, `afterBuild`, `buildPhase`, `postInstall`

## Directory structure

```
my-packages/
├── packagesets/       # JSONL packagesets (one per project)
│   ├── rails.jsonl    # Ruby project
│   └── myapp.jsonl    # Node project
├── overlays/          # Hand-written build overrides
│   ├── ruby/          # Ruby gem overlays ({ pkgs, ruby, buildGem, ... })
│   │   └── nokogiri.nix
│   └── node/          # Node package overlays ({ pkgs, nodejs, buildPackage, ... })
│       └── better-sqlite3.nix
└── nix/               # Generated — never edit
    ├── ruby/          # Per-gem derivations
    ├── node/          # Per-npm-package derivations
    ├── rails.nix      # Ruby project entry point
    ├── myapp.nix      # Node project entry point
    ├── build-gem.nix
    ├── gem-config.nix
    ├── build-npm.nix
    ├── npm-config.nix
    └── pnpmfile.cjs   # pnpm custom fetcher (serves packages from Nix store)
```

## Design

- **Nix-native fetch.** `generate` prefetches hashes; `build` uses `fetchurl`/`builtins.fetchGit`. No local cache.
- **System libraries only.** Native extensions link against nixpkgs. Vendored copies are replaced.
- **Lockfile is truth.** Packagesets are hermetic JSONL parsed once during import.
- **One derivation per package.** Individually cacheable, parallel, content-addressed.
- **Overlays win.** Manual overrides always take precedence over auto-detection.
- **Parameterized runtime.** `ruby` or `nodejs` flows through every derivation — one argument changes the whole build.
- **Multi-ecosystem.** Ruby and Node packagesets coexist in one project, sharing overlays and the generate/build/check pipeline.
