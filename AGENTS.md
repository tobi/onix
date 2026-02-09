# AGENTS.md

## Architecture

```
Gemfile.lock
    ↓
bin/fetch             gem fetch + gem unpack + git clone → cache/
    ↓
bin/generate          cache/meta/*.json → nix/gem/<name>/<version>/default.nix
                                        → nix/gem/<name>/default.nix (selectors)
                                        → nix/modules/gem.nix (catalogue)
    ↓
bin/generate-gemset   Gemfile.lock → nix/app/<project>.nix
                                   → nix/gem/<repo>/git-<rev>/default.nix
    ↓
just build [app]      nix-build → /nix/store/<hash>-<gem>-<ver>/
                      buildEnv  → unified BUNDLE_PATH
```

Everything under `nix/` is generated. Never hand-edit — run `bin/generate` and `bin/generate-gemset` to regenerate.

All customization lives in `overlays/`.

## Rules

1. Files in `nix/` are always overwritten by generators — never hand-edit.
2. Overlays in `overlays/` are hand-maintained — generators never touch them.
3. If a gem fails, decide: is it a codegen bug or a missing overlay?
   - Codegen bug → fix `bin/generate` so the fix applies to all similar gems.
   - Missing native deps → write an overlay.
4. Test with `just build`, `just lint`, and `just test <app>`.
5. **Always link against system libraries from nixpkgs.** Never use vendored/bundled copies of libraries that a gem ships in its source tree. If a gem bundles libxml2, sqlite, openssl, etc. — the overlay must pass flags like `--use-system-libraries` or `--enable-system-libraries` to `extconf.rb` so it links against the nixpkgs version. This is the whole point of hermetic builds: every shared library comes from a known nix store path, not from some tarball the gem author downloaded at release time. If the gem has no flag for system libraries, patch `extconf.rb` or provide the right `pkg-config` / header paths via environment variables so it finds the nix versions.

## Writing overlays

When `just build` fails, you'll see output like:

```
685/690 built, 5 failed.
         nix log /nix/store/...-tiktoken_ruby-0.0.15.1.drv
```

Run `nix log <drv>` to see the build log. The failure almost always falls into one of these categories:

### 1. Missing system library

The gem's `extconf.rb` calls `pkg-config` or `find_header` for a system library that isn't in the sandbox.

**Symptom:** `extconf.rb` output says `*** extconf.rb failed ***` or `checking for <header>... no`.

**Fix:** Create `overlays/<gem>.nix` that returns a list of nixpkgs deps:

```nix
# overlays/pg.nix
{ pkgs, ruby }: with pkgs; [ libpq pkg-config ]
```

```nix
# overlays/psych.nix
{ pkgs, ruby }: with pkgs; [ libyaml pkg-config ]
```

The generated derivation imports this and adds the list to `nativeBuildInputs`. The default build phase runs `ruby extconf.rb && make` automatically — if that works with the deps present, a bare list is all you need.

### 2. Custom build phase needed

The gem's extension build doesn't follow the standard `extconf.rb` + `make` pattern, or needs special flags (like `--use-system-libraries`).

**Symptom:** Build runs but produces wrong output, or the gem bundles its own copy of a library you want to use from nixpkgs.

**Fix:** Return an attrset with `deps` and `buildPhase`:

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  buildPhase = ''
    cd ext/sqlite3
    ruby extconf.rb --enable-system-libraries
    make -j$NIX_BUILD_CORES
    cd ../..
    mkdir -p lib/sqlite3
    cp ext/sqlite3/sqlite3_native.so lib/sqlite3/
  '';
}
```

The `buildPhase` replaces the default one entirely. You must:
- Compile the `.so` yourself
- Copy it to the right place under `lib/` (the `installPhase` picks up `.so` files from `lib/`)

Look at the gem's source to figure out the extension name and where it expects the `.so`:
```bash
ls cache/sources/<gem>-<version>/ext/
grep TARGET cache/sources/<gem>-<version>/ext/*/Makefile
```

### 3. Build-time gem dependency

The gem's `extconf.rb` requires another gem at build time (not runtime).

**Symptom:** `require': cannot load such file -- some_gem (LoadError)` during `extconf.rb`.

**Fix:** Import the dependency gem directly in the overlay and set `GEM_PATH`:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby }:
let
  mini_portile2 = pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; };
in {
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  buildPhase = ''
    export GEM_PATH=${mini_portile2}/${mini_portile2.prefix}
    cd ext/nokogiri
    ruby extconf.rb --use-system-libraries
    make -j$NIX_BUILD_CORES
    cd ../..
    mkdir -p lib/nokogiri
    cp ext/nokogiri/nokogiri.so lib/nokogiri/
  '';
}
```

Note: `mini_portile2` is referenced by a pinned version path (`../nix/gem/mini_portile2/2.8.9`), not through the selector, because overlays run at build time and must be deterministic.

### 4. Gem needs a non-Ruby build tool

Some gems shell out to `perl`, `python`, `cmake`, etc.

**Symptom:** `<tool>: command not found` in the build log.

**Fix:** Add the tool to the deps list:

```nix
# overlays/mittens.nix
{ pkgs, ruby }: [ pkgs.perl ]
```

### 5. Gem downloads things during build

Some gems (like `libv8-node`) try to download source during `extconf.rb`. This fails in the Nix sandbox (no network).

**Symptom:** `wget: command not found` or `curl: (7) Failed to connect`.

**Fix:** These gems need a custom overlay that either:
- Pre-provides the downloaded artifact as a Nix `fetchurl`
- Points the build at a system-installed version of the library
- Skips the download step entirely

This is the hardest category. Look at how nixpkgs handles the same gem for inspiration.

### Overlay contract

An overlay file `overlays/<name>.nix` is a function `{ pkgs, ruby }:` that returns one of:

| Return type | Meaning |
|-------------|---------|
| `[ pkg1 pkg2 ... ]` | Extra `nativeBuildInputs` only; default build phase |
| `{ deps = [...]; buildPhase = "..."; }` | Custom deps + custom build phase |

The generated derivation does:
```nix
overlay = import ../../../../overlays/<name>.nix { inherit pkgs ruby; };
overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [];
overlayBuildPhase = if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;
```

If `overlayBuildPhase` is set, it replaces the default. Otherwise the default build phase runs:
```bash
for extconf in $(find ext -name extconf.rb); do
  dir=$(dirname "$extconf")
  (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES)
done
# then copies .so from ext/ to lib/
```

### Passing `pkgs` to overlay gems

Overlay gems need `pkgs` to import their overlay. In the generated derivation, `pkgs` appears in the function args only when an overlay exists. The gemset (`nix/app/<project>.nix`) passes `pkgs` through:

```nix
"nokogiri" = gem "nokogiri" { version = "1.19.0"; pkgs = pkgs; };
```

`bin/generate-gemset` handles this automatically — any gem with an overlay gets `pkgs = pkgs;` in the gemset.

## Workflow for fixing a failing gem

```bash
# 1. Build and see what fails
just build
#    685/690 built, 5 failed.
#    nix log /nix/store/...-extralite-bundle-2.13.drv

# 2. Read the build log
nix log /nix/store/...-extralite-bundle-2.13.drv

# 3. Check the gem's source to understand its extension
ls cache/sources/extralite-bundle-2.13/ext/
cat cache/sources/extralite-bundle-2.13/ext/extralite/extconf.rb

# 4. Write the overlay
cat > overlays/extralite-bundle.nix << 'EOF'
{ pkgs, ruby }: with pkgs; [ sqlite pkg-config ]
EOF

# 5. Regenerate (overlay detection happens in bin/generate)
bin/generate

# 6. Rebuild just that gem to verify
just build-gem <app> extralite-bundle

# 7. Rebuild everything
just build

# 8. Run lints
just lint
```

## Debugging tips

```bash
# Build a single gem with verbose output
nix-build --no-out-link -K nix/gem/<name>/<version>/ --arg ruby '(import <nixpkgs> {}).ruby_3_4' --arg lib '(import <nixpkgs> {}).lib' --arg stdenv '(import <nixpkgs> {}).stdenv'

# -K keeps the build dir on failure so you can inspect it
# The path is printed: /nix/var/nix/builds/nix-build-...-1-...

# Inspect a built gem
ls $(nix-build --no-out-link -E '...')/ruby/3.4.0/gems/<name>-<version>/
ls $(nix-build --no-out-link -E '...')/ruby/3.4.0/extensions/

# Check what the selector offers
nix-instantiate --eval nix/gem/<name>/default.nix --arg lib '(import <nixpkgs> {}).lib' --arg stdenv '(import <nixpkgs> {}).stdenv' --arg ruby '(import <nixpkgs> {}).ruby_3_4'
```

## Bundler-compatible BUNDLE_PATH layout

The devshell produces a `BUNDLE_PATH` that `require "bundler/setup"` accepts without modification.

### What bundler expects

```
$BUNDLE_PATH/ruby/3.4.0/
  gems/                                    # rubygems-sourced gems
    rack-3.2.4/
    sqlite3-2.8.0/
    sqlite3-2.8.0-x86_64-linux-gnu → sqlite3-2.8.0   # platform alias
  specifications/                          # gemspecs
    rack-3.2.4.gemspec
    sqlite3-2.8.0-x86_64-linux-gnu.gemspec  # platform-qualified
  extensions/x86_64-linux/3.4.0/           # compiled .so files
    sqlite3-2.8.0/*.so
  bundler/gems/                            # git-sourced gem checkouts
    rails-60d92e4e7dfe/                    # monorepo (nested gemspecs)
    useragent-433ca320a42d/                # single gem
```

- **Rubygems gems** go in `gems/` + `specifications/`. The derivation handles this.
- **Git gems** go in `bundler/gems/<base>-<shortref>/`. The gemset generator handles this.
- **Platform gems** (ffi, nokogiri, sqlite3) need both a plain dir and a platform-qualified symlink + gemspec. The derivation creates these automatically for any gem with extensions.

### Git sources

Git gems use `bundler/gems/<base>-<shortref>/` with real `.gemspec` files inside. Bundler resolves them via `Bundler::Source::Git` → `load_spec_files`, not through `specifications/`. The shortref is the first 12 chars of the commit SHA.

## Lint suite

```bash
just lint [app]     # default: fizzy
```

| Lint | What it checks |
|------|---------------|
| `nix-eval` | Every `.nix` file in `nix/` parses without error |
| `dep-completeness` | Every gem in `Gemfile.lock` has a derivation |
| `source-clean` | No pre-built `.so/.bundle/.dylib` leaked into sources |
| `require-paths-vs-gem-metadata` | Generated `require_paths` match `.gem` YAML metadata |
| `gemspec-deps` | Gemspec runtime deps resolve within the gemset |
| `require-paths` | Every `require_path` directory exists on disk |
| `native-extensions` | Native gems have compiled `.so` files |
| `loadable` | Key gems can be `require`'d by ruby |

After writing an overlay, always run `just lint` to verify the gem is complete.

## Existing overlays

| Overlay | Type | What it provides |
|---------|------|-----------------|
| `psych.nix` | deps list | libyaml, pkg-config |
| `openssl.nix` | deps list | openssl, pkg-config |
| `puma.nix` | deps list | openssl |
| `ffi.nix` | deps list | libffi, pkg-config |
| `pg.nix` | deps list | libpq, pkg-config |
| `trilogy.nix` | deps list | openssl, zlib |
| `mittens.nix` | deps list | perl |
| `sqlite3.nix` | attrset | sqlite, pkg-config + custom buildPhase |
| `nokogiri.nix` | attrset | libxml2, libxslt + mini_portile2 as build-time dep |
