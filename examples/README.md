# examples

Nix-packaged dependency examples managed by [onix](https://github.com/tobi/onix).

- Ruby examples: this document.
- Node scenario matrix: [`examples/node/README.md`](./node/README.md).

## Quick start

```bash
onix import path/to/project     # parse Gemfile.lock → packagesets/project.jsonl
onix generate                    # prefetch hashes → nix/ruby/*.nix + nix/project.nix
onix build project               # build all gems via nix
```

## Directory structure

```
examples/
├── node/           # Node scenario matrix + fixture projects
├── packagesets/     # Hermetic JSONL packagesets (one per project)
├── overlays/        # Hand-written build overrides
└── nix/             # ⚠ Generated — never edit by hand
    ├── ruby/        # Per-gem version files (rack.nix, nokogiri.nix, ...)
    ├── project.nix  # Per-project gem selection
    ├── build-gem.nix    # Generic builder
    └── gem-config.nix   # Overlay loader
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

See `docs/overlays.md` and `docs/packageset-format.md` for details.
