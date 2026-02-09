# gemset2nix — Product Requirements Document

## Overview

**gemset2nix** turns a Ruby app's `Gemfile.lock` into hermetic, individually-cacheable Nix derivations — one per gem. It bridges scint's global gem cache with Nix's build/store model so that every gem is a reproducible, independently-cacheable store path.

## Goals

1. **Hermetic gem builds** — each gem is a self-contained Nix derivation with declared dependencies.
2. **Incremental** — regenerating skips gems whose source is already copied; Nix itself skips already-built derivations.
3. **Manual override friendly** — native gems get a `compile.nix` that is never overwritten, so hand-tuned build tweaks survive regeneration.
4. **Zero bundler at runtime** — the final `bundle-path.nix` produces a single `GEM_HOME`-compatible tree. Point `GEM_PATH` at it and go.

## Pipeline

```
Gemfile.lock + scint cache
        │
        ▼
   bin/generate          → out/gems/<name>-<version>/{default.nix, source/}
        │                  out/gems/default.nix   (top-level attrset)
        │                  out/gems/bundle-path.nix
        │                  out/gems/gemset.json
        ▼
   bin/build             → nix-build each gem in dependency order
        │
        ▼
   bin/test-bundle       → build bundle-path.nix, smoke-test, optionally exec
```

## Scripts

### `bin/generate`

| Flag | Required | Description |
|------|----------|-------------|
| `--lockfile, -l` | yes | Path to `Gemfile.lock` |
| `--output, -o` | yes | Output directory (e.g. `out/gems/`) |
| `--cache, -c` | no | Override scint cache root |

**Behaviour:**

- Parses `Gemfile.lock` via scint's `Lockfile::Parser`.
- Filters specs to current platform (prefers platform-specific over `ruby`).
- For each gem:
  - Copies extracted source from scint cache (skips if `source/` already exists).
  - Writes `default.nix` (always overwritten) with build logic.
  - Writes `compile.nix` (never overwritten) for gems needing native compilation.
- Generates top-level `default.nix` (attrset wiring all gems with `scintGemDeps`).
- Generates `bundle-path.nix` (symlinks all gem outputs into one `GEM_HOME` tree).
- Generates `gemset.json` (metadata for `bin/build`).

**Gem classification:**

| Type | Detection | Build strategy |
|------|-----------|----------------|
| Pure Ruby | No extensions | `dontBuild = true`, copy only |
| Prebuilt native | Has `.so`/`.bundle` in `lib/` | `dontBuild = true`, copy only |
| Needs compilation | Extensions declared in manifest, no prebuilt `.so` | `buildPhase` runs `extconf.rb` + `make`; `compile.nix` for overrides |

**Known native deps** (built-in mapping): psych→libyaml, openssl→openssl, puma→openssl, nokogiri→libxml2/libxslt/zlib, sqlite3→sqlite, trilogy→openssl/zlib, ffi→libffi, mittens→perl.

### `bin/build`

| Flag | Required | Description |
|------|----------|-------------|
| `--gems-dir, -g` | yes | Path to generated gems dir |
| `-j` | no | Worker count (default: nproc, max 32) |

**Behaviour:**

- Reads `gemset.json` for dependency graph.
- Builds gems in parallel, leaves-first (topological order).
- Stops on first failure with full nix error output.
- Idempotent — `nix-build` is a no-op for already-built derivations.

### `bin/test-bundle`

| Flag | Required | Description |
|------|----------|-------------|
| `--gems-dir, -g` | yes | Path to generated gems dir |
| `-- cmd...` | no | Command to exec with `GEM_PATH` set |

**Behaviour:**

- Builds `bundle-path.nix` → single nix store path.
- Without a command: smoke-tests by requiring common gems (rack, json, builder, erubi, zeitwerk).
- With `-- cmd`: execs the command with `GEM_PATH` and `GEM_HOME` pointing at the bundle path.

## Output Structure

```
out/gems/
  default.nix           # attrset of all gems, wired deps
  bundle-path.nix       # single GEM_HOME tree
  gemset.json           # metadata for build script
  rack-3.2.4/
    default.nix         # pure-ruby gem derivation
    source/             # copied from scint cache
  psych-5.3.1/
    default.nix         # native gem derivation (auto-generated)
    compile.nix         # manual build overrides (never overwritten)
    source/
```

## Dependencies

- **Runtime:** Ruby, Nix
- **Library:** scint (`lib/scint/lockfile/parser`, `lib/scint/cache/layout`, `lib/scint/spec_utils`, `lib/scint/platform`) — loaded from `../../scint/lib` relative to `bin/`.
- **Assumed:** scint cache is populated (`scint cache add --lockfile ...`) before `bin/generate` runs.

## Non-Goals

- Does not resolve gems — relies on an existing `Gemfile.lock`.
- Does not download or extract gems — relies on scint's cache.
- Does not replace scint — complements it with a Nix integration layer.

## Design Principle: Generated + Override Layers

Every per-gem directory has two Nix files with distinct ownership:

| File | Owner | Regenerated? | Purpose |
|------|-------|-------------|---------|
| `default.nix` | `bin/generate` | Always | Canonical derivation — source, deps, install logic. **Do not hand-edit.** |
| `compile.nix` | Developer | Never | Build overrides — extra `nativeBuildInputs`, `preBuild`/`postBuild`, `preInstall`/`postInstall` hooks. |

`default.nix` imports `compile.nix` and merges its attributes into the derivation. This means:

- **Regeneration is safe.** Re-running `bin/generate` refreshes wiring and dependency graphs without clobbering manual build fixes.
- **Overrides are local.** A developer fixes a native gem's build once in `compile.nix`; that fix survives every future regeneration.
- **Pure-ruby gems have no `compile.nix`.** The file is only created for gems that need native compilation, keeping the tree clean.

This two-layer pattern lets the tool own the 95% case (auto-generated, correct-by-construction derivations) while giving developers a stable escape hatch for the 5% that needs hand-tuning.

## Open Design Decisions

- The `NATIVE_DEPS` mapping is hardcoded. A plugin/override mechanism could make this extensible.
- `compile.nix` is a simple attrset. Complex builds (e.g. Nokogiri with custom libxml) may need richer override patterns.
- Platform filtering uses scint's `Platform.match_platform?` — multi-platform output (e.g. generating for Linux on macOS) is not supported.
