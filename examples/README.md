# examples

Nix-packaged Ruby gems and Node packages, managed by [onix](https://github.com/tobi/onix).

## Quick start

### Ruby

```bash
onix import path/to/project     # parse Gemfile.lock → packagesets/project.jsonl
onix generate                    # prefetch hashes → nix/ruby/*.nix + nix/project.nix
onix build project               # build all gems via nix
```

### Node

```bash
onix import-pnpm path/to/project   # parse pnpm-lock.yaml → packagesets/project.jsonl
onix generate                       # prefetch hashes → nix/node/*.nix + nix/project.nix
nix-shell tests/project/devshell.nix  # enter devShell → syncs node_modules automatically
```

On first entry, the devShell syncs the Nix-built node_modules to `./node_modules` and generates pnpm metadata so `pnpm install` exits instantly. Re-entry is instant (sentinel-gated skip).

## Directory structure

```
examples/
├── packagesets/     # Hermetic JSONL packagesets (one per project)
├── overlays/        # Hand-written build overrides
├── tests/           # Integration test projects
│   ├── run-all          # Run all Ruby project tests
│   ├── node-basic/      # Node: CJS, ESM, native, devShell, sentinel, pnpm metadata
│   ├── tsdown-starter/  # Node: Rust NAPI, TypeScript bundling, platform bindings
│   ├── remix-v3/        # Node: ESM, scoped packages, reactive primitives
│   ├── synthetic/       # Ruby: Rails-like test project
│   └── ...              # Ruby: chatwoot, discourse, forem, liquid, mastodon, rails, spree
└── nix/             # ⚠ Generated — never edit by hand
    ├── ruby/        # Per-gem version files (rack.nix, nokogiri.nix, ...)
    ├── node/        # Per-package version files (express.nix, rolldown.nix, ...)
    ├── project.nix  # Per-project: gem selection or pnpm .pnpm/ layout + devShell
    ├── build-gem.nix    # Generic gem builder
    ├── gem-config.nix   # Gem overlay loader
    ├── build-npm.nix    # Generic npm package builder
    └── npm-config.nix   # npm overlay loader
```

## Running tests

```bash
# Node projects
tests/node-basic/run-tests
tests/tsdown-starter/run-tests
tests/remix-v3/run-tests

# Ruby projects
tests/run-all

# Via Justfile
just test node-basic
just test-all
```

## Overlays

When a gem needs system libraries or custom build steps, create
`overlays/<gem-name>.nix`:

```nix
# overlays/pg.nix — simplest case: just add deps
{ pkgs, ruby }: with pkgs; [ libpq pkg-config ]

# overlays/nokogiri.nix — deps + flags
{ pkgs, ruby }: {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
}
```

Node overlays use a different signature:

```nix
# overlays/better-sqlite3.nix
{ pkgs, nodejs, ... }: {
  deps = with pkgs; [ sqlite pkg-config python3 ];
  buildFlags = "--build-from-source";
}
```

See `docs/overlays.md` and `docs/packageset-format.md` for details.
