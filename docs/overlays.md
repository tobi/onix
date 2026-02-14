# Writing Overlays

When `onix build` fails, you'll see output like:

```
  ✗ 685/690 built, 5 failed  2m34s

  ✗ extralite-bundle  →  create overlays/extralite-bundle.nix
    nix log /nix/store/...-extralite-bundle-2.13.drv
```

Run `nix log <drv>` to see the build log. The failure almost always falls into
one of these categories.

---

## Failure categories

### 1. Missing system library

The gem's `extconf.rb` calls `pkg-config` or `find_header` for a system library
that isn't in the sandbox.

**Symptom:** `*** extconf.rb failed ***` or `checking for <header>... no`

**Fix:** Create `overlays/<gem>.nix` returning a list of nixpkgs deps:

```nix
# overlays/pg.nix
{ pkgs, ruby, ... }: with pkgs; [ libpq pkg-config ]
```

```nix
# overlays/psych.nix
{ pkgs, ruby, ... }: with pkgs; [ libyaml pkg-config ]
```

### 2. Needs extconf flags (use system libraries)

The gem bundles its own copy of a library but supports a flag to use the system
version instead.

**Symptom:** Build succeeds but links against a vendored library, or you see it
downloading/compiling a bundled copy.

**Fix:** Use `extconfFlags`:

```nix
# overlays/sqlite3.nix
{ pkgs, ruby, ... }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

### 3. Build-time gem dependency

The gem's `extconf.rb` requires another gem at build time.

**Symptom:** `cannot load such file -- some_gem (LoadError)` during `extconf.rb`

**Fix:** Use `buildGems` with the `buildGem` function:

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

The `buildGem` function resolves the gem from `nix/ruby/<name>.nix` and builds it.
The framework constructs `GEM_PATH` automatically from `buildGems`.

### 4. Non-Ruby build tool needed

**Symptom:** `<tool>: command not found`

**Fix:** Add the tool to deps:

```nix
# overlays/mittens.nix
{ pkgs, ruby, ... }: [ pkgs.perl ]
```

### 5. Gem downloads things during build

Some gems (like `libv8-node`) try to download source during `extconf.rb`.
This fails in the Nix sandbox (no network).

**Symptom:** `wget: command not found` or `curl: (7) Failed to connect`

**Fix:** These gems need a custom overlay that either:
- Pre-provides the downloaded artifact as a Nix `fetchurl`
- Points the build at a system-installed version of the library
- Skips the download step entirely

This is the hardest category. Look at how nixpkgs handles the same gem.

### 6. Rust extension gems

Gems using Rust via `rb_sys`:

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

---

## Overlay contract

An overlay file `overlays/<name>.nix` is a function `{ pkgs, ruby, buildGem, ... }:`
that returns one of:

| Return type | Meaning |
|-------------|---------|
| `[ pkg1 pkg2 ... ]` | Extra `nativeBuildInputs`; default build phase |
| `{ deps = [...]; ... }` | Attrset with deps and optional hooks |

**Attrset fields:**

| Field | Type | Description |
|-------|------|-------------|
| `deps` | list | Extra `nativeBuildInputs` |
| `extconfFlags` | string | Flags appended to `ruby extconf.rb` |
| `buildGems` | list | Gem derivations needed at build time (auto `GEM_PATH`) |
| `preBuild` | string | Shell commands before build (also runs before install) |
| `postBuild` | string | Shell commands after build |
| `buildPhase` | string | **Replaces** entire default build phase |
| `postInstall` | string | Shell commands at end of install |

Hooks compose with nixpkgs' `buildRubyGem` build phases. The `preBuild`
content runs as a `preBuild` hook (and again as `preInstall` so environment
variables persist into extension compilation). You only need `buildPhase` when
extra source-level modifications are required before `gem build`.

### Build mechanism

Onix uses nixpkgs' `buildRubyGem` under the hood. The `build-gem.nix` wrapper
translates overlay parameters to `buildRubyGem` arguments:

- `deps` → `nativeBuildInputs`
- `extconfFlags` → `buildFlags` (passed to `gem install` after `--`)
- `buildGems` → `gemPath` (sets `GEM_PATH` for build-time gem dependencies)
- `preBuild` → `preBuild` + `preInstall` hooks
- `postBuild` → `postBuild` hook
- `buildPhase` → `preBuild` (runs before `gem build`)

Extension compilation is handled automatically by `gem install`.

---

## Key principles

1. **Always link against system libraries from nixpkgs.** Never use vendored
   copies. Pass flags like `--use-system-libraries` so the gem links against
   the nixpkgs version. Every shared library should come from a known nix store
   path, not from a tarball the gem author bundled.

2. **Prefer auto-detection over overlays.** If a dependency is knowable from
   `extconf.rb` analysis (e.g., `pkg_config('libffi')` → `pkgs.libffi`),
   teach `onix generate` to detect it. Overlays are for cases that can't be
   inferred automatically.

3. **Manual overlays always win.** If an overlay exists for a gem, auto-detected
   deps are ignored entirely.

---

## Workflow

```bash
# 1. Build and see what fails
onix build

# 2. Read the build log
nix log /nix/store/...-extralite-bundle-2.13.drv

# 3. Write the overlay
cat > overlays/extralite-bundle.nix << 'EOF'
{ pkgs, ruby, ... }: with pkgs; [ sqlite pkg-config ]
EOF

# 4. Rebuild just that gem to verify
onix build <project> extralite-bundle

# 5. Rebuild everything and verify
onix build
onix check
```

## Debugging tips

```bash
# Build a single gem with verbose output (-K keeps build dir on failure)
nix-build --no-out-link -K nix/<project>.nix -A <gem-name>

# Inspect a built gem
ls $(nix-build --no-out-link nix/<project>.nix -A <gem-name>)/ruby/3.4.0/gems/<name>-<version>/
ls $(nix-build --no-out-link nix/<project>.nix -A <gem-name>)/ruby/3.4.0/extensions/
```

---

## nixpkgs gem-config reference

When a gem fails, check this reference first. Extracted from
[nixpkgs gem-config](https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/ruby-modules/gem-config/default.nix).
Our overlay contract differs — adapt, don't copy verbatim.

### Quick lookup: gem → system deps

| Gem | System deps (nixpkgs attrs) | Notes |
|-----|----------------------------|-------|
| `charlock_holmes` | icu, zlib, which | |
| `cld3` | protobuf, pkg-config | |
| `curb` | curl | |
| `curses` | ncurses | |
| `eventmachine` | openssl | |
| `ffi` | libffi, pkg-config | |
| `gpgme` | gpgme, pkg-config | `--use-system-libraries` |
| `grpc` | openssl, pkg-config | disable format hardening |
| `hiredis-client` | openssl | |
| `idn-ruby` | libidn | |
| `libxml-ruby` | libxml2 | |
| `mysql` / `mysql2` | libmysqlclient, zlib, openssl | |
| `nokogiri` | libxml2, libxslt, zlib | `--use-system-libraries` |
| `openssl` | openssl | |
| `pg` | libpq, pkg-config | |
| `psych` | libyaml | |
| `puma` | openssl | |
| `re2` | re2 | `--enable-system-libraries` |
| `rmagick` | imagemagick, which, pkg-config | |
| `rpam2` | linux-pam | |
| `rugged` | cmake, pkg-config, openssl, libssh2, zlib | |
| `sqlite3` | sqlite, pkg-config | `--enable-system-libraries` |
| `tiny_tds` | freetds, openssl, pkg-config | |
| `zlib` | zlib | |

---

## Existing overlays

| Overlay | What it provides |
|---------|-----------------|
| `charlock_holmes.nix` | icu, zlib, pkg-config, which + C++17 flags |
| `commonmarker.nix` | rustc, cargo, libclang + rb_sys via buildGem |
| `debase.nix` | skipped (incompatible with Ruby 3.4) |
| `extralite-bundle.nix` | sqlite, pkg-config |
| `ffi-yajl.nix` | yajl, pkg-config + libyajl2 via buildGem |
| `ffi.nix` | libffi, pkg-config |
| `field_test.nix` | rice via buildGem |
| `google-protobuf.nix` | disable -Werror=format-security |
| `gpgme.nix` | gpgme, libgpg-error, libassuan + `--use-system-libraries` + mini_portile2 via buildGem |
| `hiredis-client.nix` | openssl, pkg-config |
| `hiredis.nix` | custom buildPhase (vendor from system lib) |
| `idn-ruby.nix` | libidn, pkg-config |
| `libv8-node.nix` | custom buildPhase (symlinks nodejs libv8) |
| `libv8.nix` | skipped (use libv8-node) |
| `libxml-ruby.nix` | libxml2, pkg-config + C_INCLUDE_PATH |
| `mini_racer.nix` | skipped (relocation error) |
| `mittens.nix` | perl |
| `mysql2.nix` | libmysqlclient, openssl, pkg-config, zlib |
| `nokogiri.nix` | libxml2, libxslt, zlib + `--use-system-libraries` + mini_portile2 via buildGem |
| `openssl.nix` | openssl, pkg-config |
| `pg.nix` | libpq, pkg-config |
| `psych.nix` | libyaml, pkg-config |
| `puma.nix` | openssl |
| `rmagick.nix` | imagemagick, pkg-config + pkg-config gem via buildGem |
| `rpam2.nix` | pam |
| `rugged.nix` | cmake, pkg-config, openssl, zlib, libssh2 |
| `sqlite3.nix` | sqlite, pkg-config + `--enable-system-libraries` |
| `therubyracer.nix` | skipped (abandoned) |
| `tiktoken_ruby.nix` | rustc, cargo, libclang + rb_sys via buildGem |
| `tokenizers.nix` | rustc, cargo, libclang + rb_sys via buildGem |
| `trilogy.nix` | openssl, zlib |
| `zlib.nix` | zlib, pkg-config |
