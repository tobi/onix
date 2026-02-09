# Matrix Builder — Design

## Goal

Build every `nix/app/<project>.nix` gemset across a matrix of:

- **Ruby versions**: `ruby_3_3`, `ruby_3_4`, `ruby_4_0` (when available)
- **Platforms**: `x86_64-linux`, `aarch64-linux`, `aarch64-darwin`, `x86_64-darwin`

One command builds the full matrix (or a slice of it).

## Approach

**Native builds, not cross-compilation.** Cross-compiling Ruby gems from
Linux→Darwin is impractical — `extconf.rb` scripts probe the host, link
against platform headers, shell out to `pkg-config`, etc. Instead:

- The `nix/` tree is platform-agnostic (it already is — `stdenv` adapts)
- Each platform runs its own `nix-build` on the same expressions
- CI dispatches to native runners (Linux x86/arm, macOS x86/arm)
- Locally, you build for your own platform across Ruby versions

## Interface

```bash
# Build fizzy on all local rubies
just matrix fizzy

# Build fizzy for specific ruby
just matrix fizzy ruby=ruby_3_3

# Build everything, all rubies
just matrix

# CI: build for this platform, specific ruby
just matrix fizzy ruby=ruby_3_4
```

## Implementation

### 1. `nix/matrix.nix` — the evaluator

Single entry point that produces a nested attrset:
`{ ruby_3_3.fizzy = [ ...derivations ]; ruby_3_4.fizzy = [...]; }`

```nix
# nix/matrix.nix
#
# Evaluate the full build matrix: rubies × apps.
#
# Returns: { <ruby>.<app> = [ derivation ... ]; }
#
# Usage:
#   nix-build nix/matrix.nix -A ruby_3_4.fizzy
#   nix-build nix/matrix.nix -A ruby_3_3
#   nix-build nix/matrix.nix                     # everything
#
{ pkgs ? import <nixpkgs> { }
, rubies ? {
    ruby_3_3 = pkgs.ruby_3_3;
    ruby_3_4 = pkgs.ruby_3_4;
  }
, apps ? [ "fizzy" "chatwoot" "discourse" ]
}:

let
  resolve = import ./modules/resolve.nix;

  buildApp = rubyName: ruby: app:
    let
      gems = resolve {
        inherit pkgs ruby;
        gemset = import (./app + "/${app}.nix");
      };
    in
    pkgs.buildEnv {
      name = "${app}-${rubyName}";
      paths = builtins.attrValues gems;
    };

  buildRuby = rubyName: ruby:
    builtins.listToAttrs (map (app: {
      name = app;
      value = buildApp rubyName ruby app;
    }) (builtins.filter (app:
      builtins.pathExists (./app + "/${app}.nix")
    ) apps));

in
builtins.mapAttrs buildRuby rubies
```

This gives you:

```bash
# Single app, single ruby → one bundle-path derivation
nix-build nix/matrix.nix -A ruby_3_4.fizzy

# All apps for one ruby
nix-build nix/matrix.nix -A ruby_3_4

# Everything
nix-build nix/matrix.nix
```

### 2. Justfile `matrix` recipe

```just
[group('build')]
matrix app="" ruby="":
    #!/usr/bin/env bash
    attr=""
    [[ -n "{{ruby}}" ]] && attr="{{ruby}}"
    [[ -n "{{app}}" ]] && attr="${attr:+$attr.}{{app}}"
    echo "Building matrix${attr:+: $attr}..."
    nix-build nix/matrix.nix --no-out-link --keep-going \
        ${attr:+-A "$attr"}
```

### 3. CI matrix (GitHub Actions)

```yaml
strategy:
  matrix:
    ruby: [ruby_3_3, ruby_3_4]
    os: [ubuntu-latest, macos-latest, macos-13]
    # macos-latest = arm64, macos-13 = x86_64

steps:
  - uses: cachix/install-nix-action@v22
  - run: nix-build nix/matrix.nix -A ${{ matrix.ruby }} --keep-going
```

Each OS runner builds natively. The `nix/` expressions are identical — 
`stdenv.hostPlatform` adapts automatically.

### 4. What already works

The current architecture is almost there:

| Layer | Platform-aware? | Notes |
|-------|----------------|-------|
| `nix/gem/*/default.nix` (selectors) | ✅ | Pass-through to versioned derivation |
| `nix/gem/*/*/default.nix` (derivations) | ✅ | Uses `stdenv.hostPlatform.parsed` for arch |
| `nix/app/*.nix` (gemsets) | ✅ | Pure data — list of `{name, version}` |
| `nix/modules/resolve.nix` | ✅ | Takes `ruby` as parameter |
| `overlays/*.nix` | ✅ | Use `pkgs.*` which adapts per platform |
| Native ext build phase | ✅ | `extconf.rb` probes build-time `stdenv` |
| Platform gemspec/symlinks | ✅ | Generated from `stdenv.hostPlatform.parsed` |
| `builtins.fetchGit` (git gems) | ✅ | Platform-independent |
| Justfile `ruby` var | ⚠️ | Single ruby, needs matrix support |
| devshell.nix files | ⚠️ | Hardcode `ruby_3_4` as default |

### 5. What needs to change

**Nothing in `nix/gem/` or `bin/generate`.** The derivations are already
parameterized by `ruby` and use `stdenv.hostPlatform` for platform detection.

Changes needed:

1. **Add `nix/matrix.nix`** — entry point for matrix builds
2. **Update Justfile** — `just matrix` recipe
3. **Devshell parameterization** — `ruby ?` argument already works
4. **CI workflow** — `.github/workflows/build.yml`

### 6. Ruby 4.0

When `ruby_4_0` lands in nixpkgs, add it to the default rubies in `matrix.nix`.
If API version changes (e.g., `4.0.0` instead of `4.0.0`), the `rubyVersion`
calculation (`${ruby.version.majMin}.0`) handles it automatically.

### 7. Caching

Each `(gem, version, ruby, platform)` tuple produces a unique store path.
Nix's content-addressed store + binary cache (Cachix/S3) means:

- First build on `ruby_3_3 + x86_64-linux` populates the cache
- Same build on another machine is a cache hit
- Switching rubies rebuilds only native gems (pure-ruby gems share source, differ by `rubyVersion` in path)

### 8. Not doing

- **Cross-compilation Linux↔Darwin**: Too fragile for native Ruby extensions.
  Each platform builds natively on its own runner.
- **Multi-platform in one `nix-build`**: Nix builds for `hostPlatform` only.
  Matrix is across CI runners, not within one evaluation.
- **Flakes**: Not needed — `nix-build nix/matrix.nix -A x.y` is simpler
  and doesn't require flake-enabled nix.
