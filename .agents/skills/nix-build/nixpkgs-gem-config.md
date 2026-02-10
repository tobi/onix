# nixpkgs gem-config Reference

> Extracted from [gem-config/default.nix](gem-config-reference.nix) (bundled).
> This is the canonical source of "how nixpkgs builds every Ruby gem with native extensions."
> Our overlay system differs — see [Translation Guide](#translation-guide) — but the **deps and flags are the same**.

## Translation Guide

nixpkgs gem-config and our overlay system solve the same problem differently:

| Aspect | nixpkgs gem-config | Our system |
|---|---|---|
| Format | `gemName = attrs: { ... }` function | `{ pkgs, ruby, buildGem, ... }: ...` file per gem |
| Sources | `fetchurl` at build time | Nix fetches via `fetchurl`/`builtins.fetchGit` (hashes prefetched by `onix generate`) |
| Build system | `buildRubyGem` (runs `gem build` + `gem install`) | `stdenv.mkDerivation` (runs `extconf.rb` + `make`) |
| Deps field | `buildInputs` / `nativeBuildInputs` (separate) | `deps` (single list, all go to `nativeBuildInputs`) |
| Build flags | `buildFlags = [ "--flag" ]` (list) | `extconfFlags = "--flag"` (string) |
| Pre-build hooks | `postPatch`, `preBuild`, `preInstall` | `beforeBuild` |
| Post-build hooks | `postInstall`, `postFixup` | `afterBuild`, `postInstall` |
| Full override | `dontBuild = false; preBuild = ...` | `buildPhase = "..."` |
| Network | Sandbox blocks; use `fetchurl` for artifacts | Sandbox blocks; sources pre-fetched; some gems need `__noChroot` or skip |
| Patching | `substituteInPlace`, `fetchpatch` | `sed -i` in `beforeBuild` or `buildPhase` |

### Key mapping: gem-config → overlay

```nix
# gem-config says:
sqlite3 = attrs: {
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ sqlite ];
  buildFlags = [ "--enable-system-libraries" ];
};

# Our overlay:
{ pkgs, ruby }: {
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

```nix
# gem-config says:
nokogiri = attrs: {
  buildFlags = [
    "--use-system-libraries"
    "--with-zlib-lib=${zlib.out}/lib"
    "--with-xml2-include=${libxml2.dev}/include/libxml2"
    ...
  ];
};

# Our overlay (simpler — pkg-config finds paths automatically):
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [ (buildGem "mini_portile2") ];
}
```

We usually **don't** need the explicit `--with-*-lib=` / `--with-*-include=` paths that nixpkgs passes, because our derivation puts all deps in `nativeBuildInputs` and `pkg-config` resolves them automatically. Only add explicit paths when `pkg-config` doesn't work for a particular gem.

### Things gem-config does that we handle differently

| gem-config pattern | Our approach |
|---|---|
| `fetchurl` / `fetchpatch` for downloads | Nix fetches sources at build time. For patches, use `sed -i` in `beforeBuild`. |
| `postPatch` + `substituteInPlace` | `sed -i` in `beforeBuild` or `buildPhase`. |
| `dontBuild = false` (to re-enable build) | Not needed — our derivations always build if extensions exist. |
| `meta.broken = true` | Skip overlay: `buildPhase = ''echo "skipping"'';` |
| `hardeningDisable = [ "format" ]` | `beforeBuild = ''export CFLAGS="$CFLAGS -Wno-error=format-security"'';` |
| `installPath=$(cat $out/nix-support/gem-meta/install-path)` | `$dest` variable in `postInstall` (= `$out/ruby/3.4.0`). Gem is at `$dest/gems/<name>-<version>/`. |
| `postFixup` with `patchelf --set-rpath` | Not typically needed; nix auto-patches rpaths. Use `postInstall` if required. |
| `propagatedBuildInputs` | Just add to `deps` — our derivations don't have the propagation distinction. |
| Version-conditional logic `lib.versionAtLeast attrs.version "X"` | Our overlays apply to all versions of a gem. If versions need different treatment, use shell conditionals in `beforeBuild` or `buildPhase` checking `$version` (pname/version are in scope). |

---

## Complete Gem Reference

Every gem with build customization in nixpkgs, organized by pattern.

### Simple system library deps

These gems just need system libraries in the sandbox. Direct translation to a deps list.

| Gem | nixpkgs deps | Notes |
|---|---|---|
| `charlock_holmes` | `which icu zlib` | |
| `cld3` | `pkg-config protobuf` | |
| `curb` | `curl` | |
| `curses` | `ncurses` | Older versions need a clang-16 compat patch |
| `do_sqlite3` | `sqlite` | |
| `eventmachine` | `openssl` | Also patches `::bind` namespace |
| `exif` | `libexif` | Uses `--with-exif-dir` |
| `exiv2` | `exiv2` | Uses `--with-exiv2-lib/include` |
| `ffi` | `pkg-config libffi` | |
| `fiddle` | `libffi` | |
| `hiredis-client` | `openssl` | |
| `idn-ruby` | `libidn` | |
| `mysql` / `mysql2` | `libmysqlclient zlib openssl` | |
| `openssl` | `openssl` (or `openssl_1_1` for < 3.0.0) | |
| `patron` | `curl` | |
| `pcaprub` | `libpcap` | |
| `psych` | `libyaml` | |
| `puma` | `openssl` | |
| `rpam2` | `linux-pam` | |
| `semian` | `openssl` | |
| `sequel_pg` | `libpq` | |
| `snappy` | `snappy` | |
| `taglib-ruby` | `taglib` | |
| `timfel-krb5-auth` | `libkrb5` | |
| `tiny_tds` | `pkg-config openssl freetds` | |
| `typhoeus` | `curl` | |
| `zlib` | `zlib` | |
| `zookeeper` | `cctools` (macOS only) | |

### System libraries with flags

These gems bundle vendored libraries but support flags to use system versions instead.

| Gem | Deps | Flag | Notes |
|---|---|---|---|
| `sqlite3` (≥1.5) | `pkg-config sqlite` | `--enable-system-libraries` | |
| `sqlite3` (<1.5) | `sqlite` | `--with-sqlite3-include/lib` (explicit paths) | Also needs `-Wno-error` flags |
| `nokogiri` | `libxml2 libxslt zlib` | `--use-system-libraries` | nixpkgs passes explicit `--with-*` paths; we use pkg-config |
| `gpgme` | `pkg-config gpgme` | `--use-system-libraries` | |
| `re2` | `re2` | `--enable-system-libraries` | |
| `rbczmq` | `zeromq czmq` | `--with-system-libs` | |
| `dep-selector-libgecode` | `gecode_3` | `USE_SYSTEM_GECODE=true` (env var) | |

### FFI library path substitution

Gems using Ruby FFI (`ffi_lib "name"`) need the absolute nix store path substituted, otherwise `dlopen` can't find the library at runtime.

| Gem | Library | nixpkgs approach |
|---|---|---|
| `opus-ruby` | `libopus` | `substituteInPlace lib/opus-ruby.rb` — replace `ffi_lib 'opus'` with full `.so` path |
| `ffi-rzmq-core` | `zeromq` | `substituteInPlace lib/ffi-rzmq-core/libzmq.rb` — replace `inside_gem = ...` with nix store path |
| `rbnacl` | `libsodium` | Replace `ffi_lib ["sodium"` with full path. Version-conditional (<6.0 vs ≥6.0). |
| `ruby-vips` | `vips`, `glib` | Replace `FFI.library_name("vips", 42)` etc. with full paths |
| `ethon` | `curl` | Replace `"libcurl"` with full path |
| `magic` | `file` (libmagic) | Patch `lib/magic/api.rb` to prepend nix store path |

**Our translation:** Use `sed -i` in `beforeBuild` or `postInstall`:

```nix
# Example: opus-ruby
{ pkgs, ruby }:
{
  deps = [ ];
  beforeBuild = ''
    sed -i "s|ffi_lib 'opus'|ffi_lib '${pkgs.libopus}/lib/libopus.so'|" lib/opus-ruby.rb
  '';
}
```

```nix
# Example: ruby-vips
{ pkgs, ruby }:
{
  deps = [ ];
  postInstall = ''
    sed -i \
      -e "s|FFI.library_name(\"vips\", 42)|\"${pkgs.vips}/lib/libvips.so\"|g" \
      -e "s|FFI.library_name(\"glib-2.0\", 0)|\"${pkgs.glib.out}/lib/libglib-2.0.so\"|g" \
      -e "s|FFI.library_name(\"gobject-2.0\", 0)|\"${pkgs.glib.out}/lib/libgobject-2.0.so\"|g" \
      $dest/gems/ruby-vips-*/lib/vips.rb
  '';
}
```

### Gems that download during build

These gems try to fetch artifacts at build time, which fails in the nix sandbox.

| Gem | What it downloads | nixpkgs fix | Our approach |
|---|---|---|---|
| `gitlab-pg_query` | libpg_query tarball | `fetchurl` + `sed` to replace URL | Pre-fetch source; `sed -i` to point at local file in `beforeBuild` |
| `pg_query` | libpg_query tarball (version-specific) | Same — `fetchurl` + `sed` | Same |
| `sass-embedded` | dart-sass binary | `substituteInPlace ext/sass/Rakefile` to use nixpkgs `dart-sass` | `beforeBuild` with `sed -i` to use `pkgs.dart-sass` |
| `h3` | h3 source for cmake build | Skip cmake, use system `h3_3` lib | `beforeBuild` with `sed -i` to point at `pkgs.h3_3` |
| `libv8` / `libv8-node` | V8 / Node.js source | `mini_racer` uses `--with-v8-dir` pointing at `nodejs.libv8` | Custom `buildPhase` symlinking nixpkgs `nodejs_24.libv8` into vendor/ |

### Hardening and compiler flag workarounds

| Gem | Issue | nixpkgs fix | Our approach |
|---|---|---|---|
| `google-protobuf` (≥3.25) | `-Werror=format-security` | `hardeningDisable = [ "format" ]` | `beforeBuild`: `export CFLAGS -Wno-error=format-security` |
| `grpc` | Same + more | `hardeningDisable = [ "format" ]` + `NIX_CFLAGS_COMPILE` | Same approach |
| `digest-sha3` | Format string issues | `hardeningDisable = [ "format" ]` | Same |
| `hpricot` | Incompatible pointer types | `NIX_CFLAGS_COMPILE = "-Wno-error=..."` + patch | `beforeBuild` with `CFLAGS` |
| `iconv` | Incompatible pointer types | `NIX_CFLAGS_COMPILE` | Same |
| `ruby-lxc` | Incompatible pointer types | `NIX_CFLAGS_COMPILE` | Same |
| `grpc` (<1.65) | GCC-14 boringssl fixes | `fetchpatch` from boringssl upstream | `sed -i` patch or skip version |
| `sqlite3` (<1.5) | Pointer type warnings | `NIX_CFLAGS_COMPILE` | Same |

### Source patching (substituteInPlace)

nixpkgs extensively uses `substituteInPlace` to patch gem source files. We use `sed -i` in `beforeBuild` or `buildPhase` for the same effect.

| Gem | What's patched | Why |
|---|---|---|
| `eventmachine` | `ext/em.cpp`: `bind (` → `::bind (` | Namespace collision |
| `gollum` | `bin/gollum`: shebang | Use nix ruby path |
| `grpc` | `Makefile`: remove encoding flag; `extconf.rb`: macOS toolchain | Various compatibility |
| `h3` | `ext/h3/Makefile`: skip cmake; `lib/h3/bindings/base.rb`: use system lib | Replace vendored build |
| `jekyll` | `lib/jekyll/commands/new.rb`: skip `bundle install` | Can't install in nix |
| `mimemagic` | Sets `FREEDESKTOP_MIME_TYPES_PATH` env var | Needs shared-mime-info |
| `mini_magick` | Adds graphicsmagick to PATH | Runtime dependency |
| `rb-readline` | `lib/rbreadline.rb`: absolute path to `infocmp` | Runtime dependency |
| `ruby-terminfo` | `extconf.rb` + `terminfo.c`: update header names, fix `rb_cData` | Ruby API changes |
| `sassc` | `lib/sassc/native.rb`: fix gem_root path | Find native lib |
| `tzinfo` | Data source file: use nix `tzdata` path | Runtime dependency |

### Rust extension gems

| Gem | Approach |
|---|---|
| `prometheus-client-mmap` (≥1.0) | Full Rust build: `fetchCargoVendor` + `cargoSetupHook` + `rustPlatform.bindgenHook`. Sets `CARGO_HOME`. Most complex Rust gem in nixpkgs. |

Our Rust gem approach is simpler because we let cargo fetch dependencies during the build (sandbox allows network for gem builds). We just need `rustc`, `cargo`, `libclang`, `rb_sys` gem on `GEM_PATH`, and the environment variables `CARGO_HOME`, `LIBCLANG_PATH`, `BINDGEN_EXTRA_CLANG_ARGS`.

### GNOME/GTK gem cascade

These gems form a dependency chain and all need similar heavy deps:

```
glib2 → gio2 → gobject-introspection → atk → gdk_pixbuf2 → gdk3 → pango → gtk3
```

Every one needs `pkg-config`, most need `gobject-introspection` + `wrapGAppsHook3`, and several need Linux-specific deps (`util-linux`, `libselinux`, `libsepol`). If a project uses any GTK/GNOME gem, expect the full cascade.

### Complex / heavyweight overlays

These gems have non-trivial build requirements:

| Gem | Complexity |
|---|---|
| `mathematical` | cmake + bison + flex + python3 + patchelf; needs post-fixup RPATH patching for lasem/glib/cairo |
| `grpc` | openssl + pkg-config; multiple patches across versions; boringssl gcc-14 fix; macOS toolchain workaround |
| `sass-embedded` | Completely replaces the build Rakefile to use system dart-sass |
| `xapian-ruby` | Custom Rakefile + system xapian + `XAPIAN_CONFIG` env var |
| `rugged` | cmake + pkg-config + openssl + libssh2 + zlib; `dontUseCmakeConfigure` (Ruby extconf drives cmake) |

### pg special case

```nix
# nixpkgs:
pg = attrs: {
  buildFlags = [ "--with-pg-config=ignore" ];  # Force pkg-config instead of pg_config
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libpq ];
};

# Our overlay (simpler — just providing libpq + pkg-config is enough):
{ pkgs, ruby }: with pkgs; [ libpq pkg-config ]
```

nixpkgs passes `--with-pg-config=ignore` to avoid pulling in the entire PostgreSQL server package. In our system, `libpq` alone (just the client library) is sufficient and `pkg-config` resolves it correctly without needing the flag.

---

## Gems NOT in gem-config (gaps to watch for)

These popular gems have **no** entry in nixpkgs gem-config. If they fail in our builds, we're on our own:

- `tiktoken_ruby` — Rust extension (we already have an overlay)
- `tokenizers` — Rust extension (we already have an overlay)
- `commonmarker` — Rust extension (we already have an overlay)
- `field_test` — needs rice gem at build time (we already have an overlay)
- `ffi-yajl` — needs yajl + libyajl2 gem (we already have an overlay)
- `hiredis` (the old Ruby gem) — vendored C code issues (we already have an overlay)
- `libv8-node` — V8 from nodejs (we already have an overlay)
- `extralite-bundle` — SQLite bindings (we already have an overlay)
- `trilogy` — MySQL wire protocol (we already have an overlay)

Our overlay collection already covers these gaps.
