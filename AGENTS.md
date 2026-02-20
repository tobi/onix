# AGENTS.md

## Commands

```bash
# Project workflow
onix init
onix import .
onix generate [--scripts none|allowed]
onix build
onix check
onix backfill

# Node-focused path
onix import --installer pnpm .
onix generate
onix build <project> node

# Diagnostics
nix log <drv>       # inspect failing build
rg -n "secret" log  # ad-hoc artifact checks
```

## Architecture

```
Gemfile.lock
    ↓
onix import           parse lockfile, clone git repos → packagesets/<name>.jsonl
pnpm-lock.yaml
    ↓
onix import           parse lockfile and workspace metadata → packagesets/<name>.jsonl
    ↓
onix generate         prefetch hashes
        → nix/ruby/<name>.nix (per gem)
        → nix/node/<name>.nix (per node package)
                                      → nix/<project>.nix (per project)
                          with optional overlays from overlays/node/
    ↓
onix build            nix-build → /nix/store/<hash>-<gem>-<ver>/
onix build <project> node
                   → /nix/store/<hash>-onix-<project>-node-modules
                   → rsync --delete workspace/node_modules (fast-path via .node_modules_id)
```

Architectural intent:

1. **Global artifact layer (Nix store):** build lockfile-resolved dependencies into immutable `/nix/store/...` outputs that are reusable across projects and CI.
2. **Project composition layer:** assemble project-scoped outputs from those artifacts (`bundlePath` for Ruby, `nodeModules` for Node).

onix is not a package registry. Lockfiles stay the source of truth; onix translates them into reproducible Nix derivations.
Ruby already follows this model as per-gem outputs composed into project bundles. Node is currently in a phase-1 project-level `nodeModules` composition path.

Everything under `nix/` is generated. Never hand-edit — run `onix generate` to regenerate.

All customization lives in `overlays/`.

## Rules

1. Files in `nix/` are always overwritten by generators — never hand-edit.
2. Overlays in `overlays/` are hand-maintained — generators never touch them.
3. If a gem fails, decide: is it a codegen bug or a missing overlay?
   - Codegen bug → fix `onix generate` so the fix applies to all similar gems.
   - Missing native deps → write an overlay.
4. Test with `onix build` and `onix check`.
5. **Always link against system libraries from nixpkgs.** Never use vendored/bundled copies of libraries that a gem ships in its source tree. If a gem bundles libxml2, sqlite, openssl, etc. — the overlay must pass flags like `--use-system-libraries` or `--enable-system-libraries` to `extconf.rb` so it links against the nixpkgs version. This is the whole point of hermetic builds: every shared library comes from a known nix store path, not from some tarball the gem author downloaded at release time. If the gem has no flag for system libraries, patch `extconf.rb` or provide the right `pkg-config` / header paths via environment variables so it finds the nix versions.
6. **Prefer generating into `default.nix` over config files or overlays.** If build requirements are knowable from gem metadata or `extconf.rb` analysis at generate time (e.g., `pkg_config('libffi')` → needs `pkgs.libffi`), teach `onix generate` to detect and inline them directly into the generated derivation. No overlay file, no config file, no indirection. Overlays are for cases that can't be inferred automatically.
7. **Script policy for pnpm is constrained to `none|allowed` only.** `all` is rejected.
8. **Follow TDD (red → green → refactor).** Start with a failing test, implement the smallest change to pass, then clean up with tests green.
9. **Run strict local quality gates before merge.** `just fmt-check`, `just check`, `just test` (or `just qa`).

## Writing overlays

When `onix build` fails, you'll see output like:

```
  ✗ 685/690 built, 5 failed  2m34s

  ✗ tiktoken_ruby  →  create overlays/tiktoken_ruby.nix
    nix log /nix/store/...-tiktoken_ruby-0.0.15.1.drv

  See AGENTS.md § Writing overlays for how to fix build failures.
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

### 2. Needs extconf flags (system libraries)

The gem bundles its own copy of a library but supports a flag to use the system version instead.

**Symptom:** Build succeeds but links against a vendored library, or you see it downloading/compiling a bundled copy.

**Fix:** Use `extconfFlags` — appended to every `ruby extconf.rb` call:

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

The default build phase handles finding `extconf.rb`, running it with the flags, `make`, and copying the `.so`. No custom `buildPhase` needed.

### 3. Build-time gem dependency

The gem's `extconf.rb` requires another gem at build time (not runtime).

**Symptom:** `require': cannot load such file -- some_gem (LoadError)` during `extconf.rb`.

**Fix:** Use `buildGems` with the `buildGem` function provided by `gem-config.nix`:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (buildGem "mini_portile2")
  ];
}
```

The `buildGem` function resolves the gem from `nix/ruby/<name>.nix` and builds it. The framework constructs `GEM_PATH` automatically from `buildGems`. No need to manually set `GEM_PATH` or write a custom `buildPhase`.

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

An overlay file `overlays/<name>.nix` is a function `{ pkgs, ruby, buildGem, ... }:` that returns one of:

| Return type | Meaning |
|-------------|---------|
| `[ pkg1 pkg2 ... ]` | Extra `nativeBuildInputs` only; default build phase |
| `{ deps = [...]; ... }` | Attrset with deps and optional hooks (see below) |

**Attrset fields:**

| Field | Type | Description |
|-------|------|-------------|
| `deps` | list | Extra `nativeBuildInputs` |
| `extconfFlags` | string | Flags appended to every `ruby extconf.rb` call |
| `preBuild` | string | Shell commands run before the build phase (also runs as `preInstall`) |
| `postBuild` | string | Shell commands run after the build phase |
| `buildPhase` | string | **Replaces** the entire default build phase |
| `postInstall` | string | Shell commands run at the end of `installPhase` |

Hooks compose with nixpkgs' `buildRubyGem` build phases. You only need `buildPhase` when extra source-level modifications are required before `gem build`.

The build uses nixpkgs' `buildRubyGem` under the hood. Extension compilation is handled automatically by `gem install`. The `preBuild` hook also runs as `preInstall` so environment variables persist into extension compilation.

## Workflow for fixing a failing gem

```bash
# 1. Build and see what fails
onix build
#    ✗ 685/690 built, 5 failed
#    ✗ extralite-bundle  →  create overlays/extralite-bundle.nix
#      nix log /nix/store/...-extralite-bundle-2.13.drv

# 2. Read the build log
nix log /nix/store/...-extralite-bundle-2.13.drv

# 3. Write the overlay
cat > overlays/extralite-bundle.nix << 'EOF'
{ pkgs, ruby }: with pkgs; [ sqlite pkg-config ]
EOF

# 4. Rebuild just that gem to verify
onix build <project> extralite-bundle

# 5. Rebuild everything
onix build

# 6. Run checks
onix check
```

## Debugging tips

```bash
# Build a single gem with verbose output
nix-build --no-out-link -K nix/<project>.nix -A <gem-name>

# -K keeps the build dir on failure so you can inspect it
# The path is printed: /nix/var/nix/builds/nix-build-...-1-...

# Inspect a built gem
ls $(nix-build --no-out-link nix/<project>.nix -A <gem-name>)/ruby/3.4.0/gems/<name>-<version>/
ls $(nix-build --no-out-link nix/<project>.nix -A <gem-name>)/ruby/3.4.0/extensions/
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
- **Git gems** go in `bundler/gems/<base>-<shortref>/`. The packageset generator handles this.
- **Platform gems** (ffi, nokogiri, sqlite3) need both a plain dir and a platform-qualified symlink + gemspec. The derivation creates these automatically for any gem with extensions.

### Git sources

Git gems use `bundler/gems/<base>-<shortref>/` with real `.gemspec` files inside. Bundler resolves them via `Bundler::Source::Git` → `load_spec_files`, not through `specifications/`. The shortref is the first 12 chars of the commit SHA.

## Lint suite

```bash
onix check
```

| Lint | What it checks |
|------|---------------|
| `nix-eval` | Every `.nix` file in `nix/` and `overlays/` parses without error |
| `packageset-complete` | Every buildable gem in a packageset has a `nix/ruby/<name>.nix` |
| `secrets` | No leaked keys, passwords, tokens in overlays, nix, or packagesets |

After writing an overlay, always run `onix check` to verify the gem is complete.

## Existing overlays

| Overlay | Type | What it provides |
|---------|------|-----------------|
| `charlock_holmes.nix` | attrset | icu, zlib, pkg-config, which + `preBuild` (C++17 flags for ICU 76+) |
| `commonmarker.nix` | attrset | rustc, cargo, libclang + `preBuild` (GEM_PATH for rb_sys, CARGO_HOME, LIBCLANG_PATH) |
| `debase.nix` | attrset | skipped build (incompatible with Ruby 3.4) |
| `extralite-bundle.nix` | attrset | sqlite, pkg-config (uses system sqlite via pkg-config) |
| `ffi-yajl.nix` | attrset | yajl, pkg-config + `preBuild` (GEM_PATH for libyajl2) |
| `ffi.nix` | deps list | libffi, pkg-config |
| `field_test.nix` | attrset | `preBuild` (GEM_PATH for rice gem — mkmf-rice at build time) |
| `google-protobuf.nix` | attrset | `preBuild` (disable -Werror=format-security) |
| `gpgme.nix` | attrset | gpgme, libgpg-error, libassuan, pkg-config + `extconfFlags = "--use-system-libraries"` + `preBuild` (GEM_PATH for mini_portile2) |
| `hiredis-client.nix` | deps list | openssl, pkg-config |
| `hiredis.nix` | attrset | hiredis C library + custom `buildPhase` (vendor/hiredis from system lib) |
| `idn-ruby.nix` | deps list | libidn, pkg-config |
| `libv8-node.nix` | attrset | custom `buildPhase` (symlinks nixpkgs nodejs libv8 into vendor/) |
| `libv8.nix` | attrset | skipped build (use libv8-node instead) |
| `libxml-ruby.nix` | attrset | libxml2, pkg-config + `preBuild` (C_INCLUDE_PATH for libxml2 headers) |
| `mini_racer.nix` | attrset | skipped build (libv8_monolith.a relocation error) |
| `mittens.nix` | deps list | perl |
| `mysql2.nix` | deps list | libmysqlclient, openssl, pkg-config, zlib |
| `nokogiri.nix` | attrset | libxml2, libxslt, pkg-config, zlib + `extconfFlags = "--use-system-libraries"` + `preBuild` (GEM_PATH for mini_portile2) |
| `openssl.nix` | deps list | openssl, pkg-config |
| `pg.nix` | deps list | libpq, pkg-config |
| `psych.nix` | deps list | libyaml, pkg-config |
| `puma.nix` | deps list | openssl |
| `rmagick.nix` | attrset | imagemagick, pkg-config + `preBuild` (GEM_PATH for pkg-config gem) |
| `rpam2.nix` | deps list | pam |
| `rugged.nix` | deps list | cmake, pkg-config, openssl, zlib, libssh2 |
| `sqlite3.nix` | attrset | sqlite, pkg-config + `extconfFlags = "--enable-system-libraries"` |
| `therubyracer.nix` | attrset | skipped build (abandoned, use mini_racer) |
| `tiktoken_ruby.nix` | attrset | rustc, cargo, libclang + `preBuild` (GEM_PATH for rb_sys, CARGO_HOME, LIBCLANG_PATH) |
| `tokenizers.nix` | attrset | rustc, cargo, libclang + `preBuild` (GEM_PATH for rb_sys, CARGO_HOME, LIBCLANG_PATH) |
| `trilogy.nix` | deps list | openssl, zlib |
| `zlib.nix` | deps list | zlib, pkg-config |

## nixpkgs gem-config reference

When a gem fails and you need to write an overlay, check this reference first. It's extracted from
[nixpkgs gem-config](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/ruby-modules/gem-config/default.nix)
and maps gem names to the deps and build tweaks that nixpkgs uses. Our overlay contract differs
(see "Writing overlays" above), so adapt — don't copy verbatim.

### Quick lookup: gem → system deps

| Gem | System deps (nixpkgs attr names) | Notes |
|-----|----------------------------------|-------|
| `atk` | gobject-introspection, wrapGAppsHook3, atk, rake, bundler, pkg-config | propagatedBuildInputs |
| `cairo` | cairo, expat, glib, pcre2, pkg-config, libsysprof-capture, libpthread-stubs, libxdmcp | |
| `cairo-gobject` | cairo, expat, pcre2, pkg-config, libsysprof-capture, libpthread-stubs, libxdmcp | |
| `charlock_holmes` | icu, zlib, which | |
| `cld3` | protobuf, pkg-config | |
| `curb` | curl | |
| `curses` | ncurses | Patch for clang 16 on older versions |
| `dep-selector-libgecode` | gecode_3 | `USE_SYSTEM_GECODE=true` |
| `do_sqlite3` | sqlite | |
| `eventmachine` | openssl | Patch `::bind` namespace |
| `exif` | libexif | `--with-exif-dir` |
| `exiv2` | exiv2 | `--with-exiv2-lib/include` |
| `ffi` | libffi, pkg-config | |
| `fiddle` | libffi | |
| `gdk_pixbuf2` | gobject-introspection, wrapGAppsHook3, gdk-pixbuf, rake, bundler, pkg-config | |
| `gdk3` | gobject-introspection, wrapGAppsHook3, gdk-pixbuf, cairo, rake, bundler, pkg-config | |
| `gio2` | glib, pcre2, pkg-config, gobject-introspection, libsysprof-capture + Linux: util-linux, libselinux, libsepol | |
| `glib2` | glib, pcre2, pkg-config, libsysprof-capture | |
| `gobject-introspection` | gobject-introspection, wrapGAppsHook3, glib, pcre2, pkg-config, libsysprof-capture | |
| `gpgme` | gpgme, pkg-config | `--use-system-libraries` |
| `grpc` | openssl, pkg-config | `hardeningDisable = ["format"]`; patches for gcc-14/boringssl |
| `gtk3` | many GTK deps, binutils, pkg-config | Complex propagated deps |
| `h3` | h3_3 (from nixpkgs) | Patch extconf to skip cmake, point at system lib |
| `hiredis-client` | openssl | |
| `iconv` | libiconv (macOS) | `--with-iconv-dir` |
| `idn-ruby` | libidn | |
| `libxml-ruby` | libxml2 | `--with-xml2-lib/include` |
| `mathematical` | cairo, fribidi, gdk-pixbuf, glib, libxml2, pango, cmake, bison, flex, python3, patchelf | Complex postFixup RPATH patching |
| `magic` | file (libmagic) | Patches lib path in ruby source |
| `maxmind_geoip2` | libmaxminddb | `--with-maxminddb-lib/include` |
| `mysql` / `mysql2` | libmysqlclient, zlib, openssl | |
| `ncursesw` | ncurses | `--with-cflags/ldflags` |
| `nokogiri` | libxml2, libxslt, zlib (+ libiconv on macOS) | `--use-system-libraries` with explicit `--with-*-lib/include` |
| `openssl` | openssl (or openssl_1_1 for < 3.0.0) | |
| `opus-ruby` | libopus | Patches FFI lib path |
| `ovirt-engine-sdk` | curl, libxml2 | Disable several `-Werror` flags |
| `pango` | libdatrie, libthai, fribidi, harfbuzz, pcre2, pkg-config + Linux: libselinux, libsepol, util-linux | propagatedBuildInputs: gobject-introspection, wrapGAppsHook3 |
| `patron` | curl | |
| `pcaprub` | libpcap | |
| `pg` | libpq, pkg-config | `--with-pg-config=ignore` forces pkg-config |
| `psych` | libyaml | |
| `puma` | openssl | |
| `pygments.rb` | python3 | |
| `rbczmq` | zeromq, czmq | `--with-system-libs` |
| `re2` | re2 | `--enable-system-libraries` |
| `rdiscount` | discount | Patch to use system libmarkdown |
| `rmagick` | imagemagick, which, pkg-config | |
| `rpam2` | linux-pam | |
| `rugged` | cmake, pkg-config, openssl, libssh2, zlib (+ libiconv on macOS) | `--with-ssh`; `dontUseCmakeConfigure` |
| `sassc` | libsass, rake | Patches native lib path |
| `sass-embedded` | dart-sass | Patches Rakefile to use system dart-sass |
| `semian` | openssl | |
| `sequel_pg` | libpq | |
| `snappy` | snappy | |
| `sqlite3` | sqlite, pkg-config | `--enable-system-libraries` (≥1.5.0) or `--with-sqlite3-lib/include` (older) |
| `taglib-ruby` | taglib | |
| `timfel-krb5-auth` | libkrb5 | |
| `tiny_tds` | freetds, openssl, pkg-config | |
| `typhoeus` | curl | |
| `xapian-ruby` | xapian, zlib, rake, bundler, pkg-config | Custom Rakefile |
| `zlib` | zlib | |
| `zookeeper` | cctools (macOS) | |

### Patterns worth knowing

#### FFI gems that hardcode library paths

Gems using FFI (`ffi_lib "name"`) need the absolute nix store path substituted at build time.
nixpkgs uses `substituteInPlace` to replace the library name with the full `.so` path:

```nix
# Example: opus-ruby
postPatch = ''
  substituteInPlace lib/opus-ruby.rb \
    --replace "ffi_lib 'opus'" \
              "ffi_lib '${libopus}/lib/libopus.so'"
'';
```

Other gems that need this pattern: `ethon` (curl), `ffi-rzmq-core` (zeromq), `rbnacl` (libsodium),
`ruby-vips` (vips, glib, gobject), `h3` (h3_3).

In our overlay contract, use `preBuild` or `buildPhase` to do the substitution.

#### Gems that download during build

These gems try to fetch source/binaries during `extconf.rb` and fail in the Nix sandbox:

| Gem | What it downloads | nixpkgs fix |
|-----|-------------------|-------------|
| `gitlab-pg_query` / `pg_query` | libpg_query tarball | `fetchurl` + `sed` to replace URL with local path |
| `mini_racer` | V8 via libv8 | `--with-v8-dir` pointing at nodejs.libv8 |
| `h3` | h3 source for cmake build | Skip cmake, substitute system lib path |
| `sass-embedded` | dart-sass binary | Replace Rakefile to use nixpkgs `dart-sass` |

#### Disabling hardening flags

Some gems fail with GCC/Clang security hardening. nixpkgs disables specific flags:

```nix
# google-protobuf (>= 3.25.0)
hardeningDisable = [ "format" ];

# grpc
hardeningDisable = [ "format" ];
```

In our overlay contract, use `preBuild` to set `NIX_CFLAGS_COMPILE` or `CFLAGS`:
```nix
preBuild = ''
  export CFLAGS="$CFLAGS -Wno-error=format-security"
'';
```

#### Gems with Rust extensions

Modern gems increasingly use Rust via `rb_sys`. Pattern (already used for commonmarker, tiktoken_ruby, tokenizers):

```nix
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ rustc cargo libclang ];
  buildGems = [
    (buildGem "rb_sys")
  ];
  preBuild = ''
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
    export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.stdenv.cc.cc.version}/include"
  '';
}
```

`prometheus-client-mmap` (≥1.0) also needs Rust + `cargoSetupHook` + `fetchCargoVendor` — the most
complex Rust overlay in nixpkgs.

#### GNOME/GTK gems

GNOME binding gems (`atk`, `cairo`, `gdk_pixbuf2`, `gdk3`, `gio2`, `glib2`, `gobject-introspection`,
`gtk3`, `pango`) all need:
- `pkg-config` in nativeBuildInputs
- `gobject-introspection` + `wrapGAppsHook3` in propagatedBuildInputs
- `DarwinTools` on macOS
- `rake` + `bundler` for some

These are heavyweight overlays. If a project uses them, expect a cascade of deps.

#### Version-conditional fixes

nixpkgs often applies different fixes per gem version. When writing overlays, check
the packageset JSONL for the exact version and tailor accordingly:

```nix
# sqlite3: different approach before/after 1.5.0
# openssl: uses openssl_1_1 for versions < 3.0.0
# grpc: different patches for < 1.53, < 1.65, < 1.68.1
```
