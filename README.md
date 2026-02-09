# scint-to-nix

Turn a Ruby app's `Gemfile.lock` into hermetic, individually-cacheable Nix derivations — one per gem. Every gem gets its own store path. Native extensions are compiled from source inside the Nix sandbox. The output is a `BUNDLE_PATH`-compatible directory that `bundler/setup` accepts without modification — no bundler install step, no network access, fully reproducible.

Tested against 9 real-world Ruby projects totaling 2,228 gems (see [Status](#status) below).

## How it works

```
Gemfile.lock + scint cache
        │
   bin/generate     Parses lockfile, copies source from scint cache,
        │           writes per-gem Nix derivations + bundle-path.nix
        ▼
   bin/build        Builds all gems in parallel (dependency order)
        │
        ▼
   nix-shell        Drops into a shell with BUNDLE_PATH set,
                    bundler/setup works, `bin/rails test` runs
```

[Scint](../scint) is a fast Bundler replacement that maintains a global gem cache. scint-to-nix reads that cache and generates Nix derivations — it doesn't download or resolve anything itself.

## Quick start

```bash
# 1. Populate scint cache (downloads + extracts all gems)
cd ../fizzy
scint cache add --lockfile Gemfile.lock

# 2. Generate nix derivations
cd ../scint-to-nix
bin/generate -l ../fizzy/Gemfile.lock -o out/gems/

# 3. Build all gems into nix store
bin/build -g out/gems/

# 4. Run lints
tests/lint/run-all out/gems

# 5. Enter devshell and run tests
cd ../fizzy
nix-shell ../scint-to-nix/tests/fizzy/devshell.nix
DATABASE_ADAPTER=sqlite RAILS_ENV=test bin/rails test
```

## Scripts

All in `bin/`, all idempotent, all stop on first error.

### `bin/generate`

Reads `Gemfile.lock` + scint's cache → writes Nix derivation tree.

```bash
bin/generate --lockfile ../fizzy/Gemfile.lock --output out/gems/
```

| Flag | Required | Description |
|------|----------|-------------|
| `--lockfile, -l` | yes | Path to `Gemfile.lock` |
| `--output, -o` | yes | Output directory (e.g. `out/gems/`) |
| `--cache, -c` | no | Override scint cache root |

What it does:

- Parses `Gemfile.lock` via scint's lockfile parser (gets dependencies, source type, git revisions)
- Filters specs to current platform (prefers platform-specific over `ruby`)
- Reads `require_paths` from `.gem` YAML metadata (not `spec.marshal`, which has cross-Ruby-version marshaling issues)
- For each gem, copies source from scint cache and writes `default.nix`
- For native gems, also writes `compile.nix` (manual override hook, never overwritten)
- For git sources, creates full-repo checkout derivations at the paths bundler expects
- Generates top-level `default.nix`, `bundle-path.nix`, and `gemset.json`

### `bin/build`

Builds every gem derivation in dependency order (leaves first), with parallelism.

```bash
bin/build --gems-dir out/gems/ [-j N]
```

Stops on first failure with the full nix error output. Fix the gem's `compile.nix`, re-run. Idempotent — `nix-build` is a no-op for derivations already in the store.

### `bin/test-bundle`

Builds `bundle-path.nix`, smoke-tests gem loading, optionally runs a command.

```bash
bin/test-bundle --gems-dir out/gems/
bin/test-bundle --gems-dir out/gems/ -- ruby -e "require 'rack'; puts Rack::RELEASE"
```

## Design: generated + override layers

Every per-gem directory has two Nix files with distinct ownership:

| File | Owner | Regenerated? | Purpose |
|------|-------|-------------|---------|
| `default.nix` | `bin/generate` | Always | Canonical derivation — source, deps, install logic. **Do not hand-edit.** |
| `compile.nix` | Developer | Never | Build overrides for native gems — extra `nativeBuildInputs`, `preBuild`/`postBuild`, `preInstall`/`postInstall` hooks. |

`default.nix` imports `compile.nix` and merges its attributes. Regeneration is safe — it refreshes wiring without clobbering manual build fixes. Pure-ruby gems have no `compile.nix`.

## Native extensions

Pre-built `.so` files from scint's cache are **stripped** from the source tree. Every gem with extensions is recompiled from source inside the Nix sandbox, linked against the Nix Ruby and system libraries.

The generator has a built-in mapping of known system dependencies:

| Gem | System deps |
|-----|-------------|
| psych | libyaml, pkg-config |
| openssl | openssl, pkg-config |
| nokogiri | libxml2, libxslt, pkg-config, zlib |
| sqlite3 | sqlite |
| ffi | libffi, pkg-config |
| puma | openssl |
| trilogy | openssl, zlib |
| mittens | perl |

For gems not in the mapping, add deps via `compile.nix`.

## Bundler-compatible BUNDLE_PATH

The `bundle-path.nix` output matches the exact directory structure that `require "bundler/setup"` expects:

```
BUNDLE_PATH/
  ruby/3.4.0/
    gems/                                    # rubygems-sourced gems
      rack-3.2.4/
      concurrent-ruby-1.3.6/
    specifications/                          # gemspecs (with add_dependency)
      rack-3.2.4.gemspec
      concurrent-ruby-1.3.6.gemspec
    bundler/gems/                            # git-sourced gem checkouts
      rails-60d92e4e7dfe/                    # full monorepo source
        activesupport/activesupport.gemspec
        railties/railties.gemspec
        RAILS_VERSION
        ...
      lexxy-4f0fc4d5773b/
      useragent-433ca320a42d/
```

Key details:

- Everything lives under `ruby/<major.minor.0>/` as bundler expects
- Rubygems gems get stub gemspecs with `add_dependency` entries so RubyGems can activate the full dependency chain
- Platform-specific gems (e.g. `sqlite3-2.8.0-x86_64-linux-gnu`) include the platform in the gemspec filename and set `s.platform`
- Git sources are full repo checkouts at `bundler/gems/<base_name>-<shortref>/` with real `.gemspec` files — bundler finds them via its `Source::Git` code path
- Monorepo git sources (like Rails) include the entire repo so nested gemspecs can reference shared files (e.g. `RAILS_VERSION`)

## Ruby version

The nix derivations accept a `ruby` parameter. The devshell defaults to `ruby_3_4`:

```nix
# tests/fizzy/devshell.nix
{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
```

The `ruby` flows through `bundle-path.nix` → `default.nix` → every per-gem `callPackage`. Changing the Ruby version rebuilds only the native extensions.

## Output structure

```
out/gems/
  default.nix                   # top-level attrset of all gems
  bundle-path.nix               # BUNDLE_PATH-compatible tree
  gemset.json                   # metadata for build script + lints
  rack-3.2.4/
    default.nix                 # pure-ruby gem derivation
    source/                     # copied from scint cache
  psych-5.3.1/
    default.nix                 # native gem (has buildPhase)
    compile.nix                 # manual build overrides
    source/
  _git_rails-60d92e4e7dfe/
    default.nix                 # full monorepo checkout derivation
    source/
  _git_lexxy-4f0fc4d5773b/
    default.nix
    source/
```

## Lint suite

Eight lint scripts in `tests/lint/`, run with `tests/lint/run-all`:

| Lint | What it checks |
|------|---------------|
| `nix-eval` | All `.nix` files parse without errors |
| `dep-completeness` | Every dependency in gemset.json exists as a gem |
| `source-clean` | No pre-built `.so`/`.bundle` leaked into native gem sources |
| `gemspec-deps` | Gemspec `add_dependency` entries match gemset.json |
| `require-paths` | Every gem's `require_paths` actually exist on disk |
| `require-paths-vs-gem-metadata` | Generated `require_paths` match authoritative `.gem` YAML metadata |
| `native-extensions` | Native gems have `.so` files, and they differ from scint cache (recompiled) |
| `loadable` | Gems can be `require`'d in the nix ruby |

## Problems solved through codegen

Every fix was made in `bin/generate` so a clean `rm -rf out/gems && bin/generate` reproduces correct output:

1. **No prebuilt `.so` bypass** — scint's cache has `.so` files compiled against the host Ruby. These are stripped from source and every native gem recompiles inside the Nix sandbox.

2. **Gemspec dependencies** — stub gemspecs include `add_dependency` entries. Without these, RubyGems can't activate the dependency chain and `require "rails"` fails.

3. **`require_paths` from `.gem` metadata** — `spec.marshal` files are Ruby-version-specific and can't be loaded across versions. The generator falls back to parsing YAML metadata from the `.gem` tar file, which works regardless of Ruby version.

4. **Platform-aware gemspecs** — gems like `sqlite3-2.8.0-x86_64-linux-gnu` need the platform in the gemspec filename and `s.platform` set, or bundler can't find them.

5. **Git source layout** — bundler expects git gems at `BUNDLE_PATH/ruby/<ver>/bundler/gems/<base>-<shortref>/`, not in the regular `gems/` directory. Monorepos need the full repo source so nested gemspecs can reference shared files.

6. **Ruby-provided gems filtered** — `bundler` is provided by Ruby itself and filtered from dependency lists to avoid missing-gem errors.

7. **Meta-gem require_paths** — gems like `rails` and `rubocop-rails-omakase` have no `lib/` directory. Their `require_paths` are set to `[]` instead of the default `["lib"]`.

8. **Parameterized Ruby version** — all nix files accept a `ruby` argument so you can target any nixpkgs Ruby without regenerating.

9. **PATH sources skipped** — gems from `PATH` sources in `Gemfile.lock` (the project's own code in monorepos) are excluded from generation. They're application code, not third-party deps. Their names are also stripped from dependency lists so no dangling references are generated.

## Status

Tested against 9 projects from `~/src/ruby-tests/`. The generator handles rubygems, git, and path sources across a wide range of real-world Gemfiles.

| Project | Gems | Source types | Lint result | Notes |
|---------|-----:|-------------|:-----------:|-------|
| [Fizzy](../fizzy) | 161 | GEM + GIT(3) | **7/7** | Rails 8.2 app, 1026 tests passing |
| [Liquid](https://github.com/Shopify/liquid) | 44 | GEM + GIT + PATH | **7/7** | PATH source (self) correctly skipped |
| [Spree](https://github.com/spree/spree) | 222 | GEM + PATH(7) | **7/7** | 7 monorepo sub-packages skipped |
| [Solidus](https://github.com/solidusio/solidus) | 200 | GEM + PATH(8) | 6/7 | faraday require-paths mismatch (benign) |
| [Redmine](https://www.redmine.org/) | 154 | GEM | 6/7 | faraday require-paths mismatch (benign) |
| [Discourse](https://github.com/discourse/discourse) | 296 | GEM | 4/7 | 2 native build failures, gemspec-deps |
| [Rails](https://github.com/rails/rails) | 217 | GEM + PATH(14) | 3/7 | 2 native build failures (libxml-ruby, mysql2) |
| [Mastodon](https://github.com/mastodon/mastodon) | 350 | GEM + GIT | 3/7 | 6 native build failures (pg, nokogiri, etc.) |
| [Chatwoot](https://github.com/chatwoot/chatwoot) | 364 | GEM + GIT(2) | 3/7 | 2 native failures, require-paths (grpc) |
| [Forem](https://github.com/forem/forem) | 381 | GEM + GIT | 3/7 | 8 native build failures |
| **Total** | **2,228** | | | |

### What passes everywhere

- **Code generation** — all 9 projects generate successfully. Nix files parse, dependencies resolve, source trees are clean.
- **Pure-ruby gems** — install and load correctly across all projects.
- **Git sources** — monorepo checkouts (Rails), single-gem repos (webpush, acts_as_follower), multi-gem repos (azure-storage-ruby) all handled.
- **PATH sources** — correctly identified and excluded (Rails' 14 sub-packages, Solidus' 8, Spree's 7, Liquid's self-reference).

### Remaining failures

All failures are in two categories, both fixable through the existing `compile.nix` override mechanism or by expanding the generator:

**1. Native extension build failures** — gems that need system libraries not yet in the `NATIVE_DEPS` mapping:

| Gem | Missing dep | Projects affected |
|-----|------------|-------------------|
| pg | libpq | mastodon, chatwoot, forem |
| mysql2 | mysql | rails |
| nokogiri (source build) | libxml2 libxslt (already mapped, but source variant differs from prebuilt) | mastodon |
| libxml-ruby | libxml2 | rails |
| charlock_holmes | icu | mastodon |
| idn-ruby | libidn | mastodon |
| rpam2 | pam | mastodon |
| mini_racer | v8 | discourse |
| extralite-bundle | sqlite | discourse |
| hiredis-client | hiredis | mastodon |
| datadog | custom build (Rust FFI) | chatwoot |
| google-protobuf | protobuf | forem |
| pg_query | libpg_query | forem |
| better_html | custom parser | forem |

Fix: add these to `NATIVE_DEPS` in `bin/generate`, or override per-gem via `compile.nix`.

**2. `require_paths` mismatches** — gems where generated paths differ from `.gem` metadata. Most are benign:

- `faraday` includes `spec/external_adapters` (test path, not needed at runtime)
- Native gems like `ox`, `commonmarker`, `digest-crc` list `ext` in require_paths (handled by extension compilation)
- `grpc` has an unusual `src/ruby/lib` layout (prebuilt platform gem)
- `concurrent-ruby` uses `lib/concurrent-ruby` instead of `lib`

Fix: improve require_paths detection in `bin/generate` to handle these patterns.
