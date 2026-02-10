---
name: nix-build
description: Fix failing Ruby gem Nix builds by writing overlays. Use when `just build` reports failures and outputs a build log file. Covers diagnosing build errors, writing overlay files, and the full fix-rebuild-verify cycle.
---

# Fixing Gem Build Failures

When `just build` reports failures it writes a log file with all error details:

```
3780/3786 built, 6 failed.
Full build log with failure details: /tmp/gem-build-XXXXXX.log
Fix with: /nix-build skill — refer to /tmp/gem-build-XXXXXX.log
```

Read that file. Each failure section starts with `--- nix log /nix/store/...-<gem>-<version>.drv ---` followed by the full build output.

## Diagnosis Workflow

### Step 1 — Read the build log

Open the temp file referenced in the `just build` output. For each failed gem, find its `--- nix log ... ---` section and identify the error category:

| Log pattern | Category | Jump to |
|---|---|---|
| `checking for <header>... no` | Missing system library | [Pattern 1](#pattern-1--missing-system-library) |
| `*** extconf.rb failed ***` | Missing system library | [Pattern 1](#pattern-1--missing-system-library) |
| `pkg-config --libs <name>` fails | Missing system library | [Pattern 1](#pattern-1--missing-system-library) |
| Build links vendored lib copy | Needs system-library flags | [Pattern 2](#pattern-2--use-system-libraries-flag) |
| `cannot load such file -- <gem>` | Build-time gem dependency | [Pattern 3](#pattern-3--build-time-gem-dependency) |
| `<tool>: command not found` | Missing build tool | [Pattern 4](#pattern-4--missing-build-tool) |
| `curl: Failed to connect` / no network | Downloads during build | [Pattern 5](#pattern-5--gem-downloads-during-build) |
| `-Werror=format-security` | Hardening flag conflict | [Pattern 6](#pattern-6--disable-hardening-flags) |
| `rustc X.Y.Z is not supported` | Rust version mismatch | [Pattern 7](#pattern-7--rust-extension-gems) |
| Rust/cargo/bindgen errors | Rust extension | [Pattern 7](#pattern-7--rust-extension-gems) |
| `-std=c++11` with new library | C++ standard mismatch | [Pattern 8](#pattern-8--c-standard-mismatch) |
| Gem is abandoned / incompatible | Skip the build | [Pattern 9](#pattern-9--skip-unbuildable-gems) |

### Step 2 — Check nixpkgs gem-config

Always check how nixpkgs handles the same gem before writing an overlay:

```bash
NIXPKGS=$(nix-instantiate --eval -E '(import <nixpkgs> {}).path' 2>/dev/null | tr -d '"')
grep -A 20 '"<gem-name>"' "$NIXPKGS/pkgs/development/ruby-modules/gem-config/default.nix"
```

The [nixpkgs-research skill](/home/tobi/.pi/agent/skills/nixpkgs-research/SKILL.md) has detailed instructions for searching nixpkgs packages and inspecting headers/libs/pkg-config files. Load it if you need to find the right nixpkgs package for a library.

### Step 3 — Write the overlay

Create `overlays/<gem-name>.nix`. See the patterns below.

### Step 4 — Rebuild

```bash
onix build <project> <gem>     # rebuild a single gem
onix build                     # full rebuild
onix check                     # verify completeness
```

For faster iteration on a single gem:

```bash
nix-build --no-out-link -K nix/<project>.nix -A <gem-name>
```

`-K` keeps the build directory on failure for inspection.

---

## Overlay Contract

An overlay file `overlays/<name>.nix` is a function `{ pkgs, ruby, buildGem, ... }:` returning one of:

### Simple: deps list only

When the gem just needs system libraries and the default `extconf.rb && make` works:

```nix
{ pkgs, ruby, ... }:
with pkgs;
[
  libffi
  pkg-config
]
```

### Full: attrset with hooks

When you need flags, environment setup, or custom build logic:

```nix
{ pkgs, ruby, ... }:
{
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
  beforeBuild = ''
    export SOME_VAR="value"
  '';
}
```

| Field | Type | Description |
|---|---|---|
| `deps` | list | Added to `nativeBuildInputs` (system libs, tools) |
| `extconfFlags` | string | Appended to every `ruby extconf.rb` invocation |
| `beforeBuild` | string | Shell commands before the default build loop |
| `afterBuild` | string | Shell commands after the default build loop |
| `buildPhase` | string | **Replaces** the entire default build phase |
| `postInstall` | string | Shell commands at end of install (`$dest` = `$out/ruby/3.4.0`) |

The default build phase (when `buildPhase` is NOT set) runs:

```bash
extconfFlags="<overlayExtconfFlags>"    # from overlay, or ""
<overlayBeforeBuild>                     # from overlay, or ""
for extconf in $(find ext -name extconf.rb); do
  dir=$(dirname "$extconf")
  (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)
done
# copies .so from ext/ into lib/
<overlayAfterBuild>                      # from overlay, or ""
```

**Prefer hooks over `buildPhase`.** Only use `buildPhase` when the default `extconf.rb + make` loop fundamentally won't work (e.g., Rust gems that need pre-build lockfile manipulation, or gems where you must replace vendored source before extconf runs).

---

## Patterns

### Pattern 1 — Missing system library

The most common failure. The gem's `extconf.rb` looks for a header or library via `pkg-config`, `find_header`, or `have_library` and it's not in the sandbox.

**Overlay — just list the deps:**

```nix
# overlays/pg.nix
{ pkgs, ruby, ... }: with pkgs; [ libpq pkg-config ]
```

```nix
# overlays/mysql2.nix
{ pkgs, ruby, ... }: with pkgs; [ libmysqlclient openssl pkg-config zlib ]
```

```nix
# overlays/idn-ruby.nix
{ pkgs, ruby, ... }: with pkgs; [ libidn pkg-config ]
```

**When headers are in a non-standard include path**, expose them:

```nix
# overlays/libxml-ruby.nix — libxml2 headers are under include/libxml2/
{ pkgs, ruby }:
{
  deps = with pkgs; [ libxml2 pkg-config ];
  beforeBuild = ''
    export C_INCLUDE_PATH="${pkgs.libxml2.dev}/include/libxml2''${C_INCLUDE_PATH:+:$C_INCLUDE_PATH}"
  '';
}
```

**Rule of thumb:** if the gem uses `pkg-config` in its extconf, always include `pkgs.pkg-config` in deps.

#### Common gem → nixpkgs mappings

| Gem | nixpkgs deps |
|---|---|
| `pg` | `libpq pkg-config` |
| `mysql2` | `libmysqlclient openssl pkg-config zlib` |
| `sqlite3` | `sqlite pkg-config` (+ `extconfFlags`) |
| `ffi` | `libffi pkg-config` |
| `psych` | `libyaml pkg-config` |
| `openssl` | `openssl pkg-config` |
| `puma` | `openssl` |
| `zlib` | `zlib pkg-config` |
| `nokogiri` | `libxml2 libxslt pkg-config zlib` (+ `extconfFlags` + gem dep) |
| `charlock_holmes` | `icu zlib pkg-config which` |
| `idn-ruby` | `libidn pkg-config` |
| `rmagick` | `imagemagick pkg-config` (+ gem dep) |
| `hiredis-client` | `openssl pkg-config` |
| `trilogy` | `openssl zlib` |
| `rpam2` | `pam` |
| `rugged` | `cmake pkg-config openssl zlib libssh2` |
| `gpgme` | `gpgme libgpg-error libassuan pkg-config` (+ `extconfFlags` + gem dep) |

### Pattern 2 — Use-system-libraries flag

The gem bundles a vendored copy of a library but supports a flag to use the system version. **Always prefer system libraries** — this is the whole point of hermetic Nix builds.

**Look for these clues in `extconf.rb`:**
- `enable_config('system-libraries')`
- `with_config('use-system-libraries')`
- Check if the gem's README mentions `--use-system-libraries`

```nix
# overlays/sqlite3.nix
{ pkgs, ruby }:
{
  deps = with pkgs; [ sqlite pkg-config ];
  extconfFlags = "--enable-system-libraries";
}
```

```nix
# overlays/nokogiri.nix
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [ (buildGem "mini_portile2") ];
}
```

```nix
# overlays/gpgme.nix
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ gpgme libgpg-error libassuan pkg-config ];
  extconfFlags = "--use-system-libraries";
  buildGems = [ (buildGem "mini_portile2") ];
  beforeBuild = ''
    export RUBY_GPGME_USE_SYSTEM_LIBRARIES=1
  '';
}
```

Some gems also check environment variables like `BUNDLE_BUILD__NOKOGIRI`, `RUBY_GPGME_USE_SYSTEM_LIBRARIES`, etc. Set these in `beforeBuild` when needed.

### Pattern 3 — Build-time gem dependency

The gem's `extconf.rb` does `require 'some_gem'` at build time. This fails because only the gem being built is in the sandbox.

**Fix:** Use `buildGems` with the `buildGem` function:

```nix
# overlays/nokogiri.nix
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ libxml2 libxslt pkg-config zlib ];
  extconfFlags = "--use-system-libraries";
  buildGems = [ (buildGem "mini_portile2") ];
}
```

```nix
# overlays/rmagick.nix — needs the pkg-config Ruby gem
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ imagemagick pkg-config ];
  buildGems = [ (buildGem "pkg-config") ];
}
```

```nix
# overlays/field_test.nix — needs the rice gem (mkmf-rice)
{ pkgs, ruby, buildGem, ... }:
{
  buildGems = [ (buildGem "rice") ];
}
```

**Multiple gem deps:** Just list them all in `buildGems`:

```nix
buildGems = [ (buildGem "dep1") (buildGem "dep2") ];
```

### Pattern 4 — Missing build tool

Some gems shell out to non-Ruby tools during build.

```nix
# overlays/mittens.nix — needs perl
{ pkgs, ruby }: [ pkgs.perl ]

# overlays/rugged.nix — needs cmake for vendored libgit2
{ pkgs, ruby }: with pkgs; [ cmake pkg-config openssl zlib libssh2 ]
```

### Pattern 5 — Gem downloads during build

The Nix sandbox blocks network access. If a gem tries to download source or binaries during `extconf.rb`, you must either provide the artifact as a Nix input or point the build at a system-installed version.

```nix
# overlays/libv8-node.nix — provide V8 from nixpkgs nodejs
{ pkgs, ruby }:
let libv8 = pkgs.nodejs_24.libv8; in
{
  deps = [ ];
  buildPhase = ''
    platform=$(ruby -e 'puts Gem::Platform.local.to_s.gsub(/-darwin-?\d+/, "-darwin")')
    mkdir -p vendor/v8/include
    ln -sf ${libv8}/include/* vendor/v8/include/
    mkdir -p "vendor/v8/$platform/libv8/obj"
    ln -s ${libv8}/lib/libv8.a "vendor/v8/$platform/libv8/obj/libv8_monolith.a"
    cat > ext/libv8-node/.location.yml <<YAML
    --- !ruby/object:Libv8::Node::Location::Vendor {}
    YAML
  '';
}
```

### Pattern 6 — Disable hardening flags

Some gems fail with GCC security hardening (common with protobuf, grpc).

```nix
# overlays/google-protobuf.nix
{ pkgs, ruby }:
{
  deps = [ ];
  beforeBuild = ''
    export CFLAGS="$CFLAGS -Wno-error=format-security"
    export NIX_CFLAGS_COMPILE="''${NIX_CFLAGS_COMPILE:-} -Wno-error=format-security"
  '';
}
```

Note the `''${...}` syntax — this is how you escape `${` inside Nix multi-line strings.

### Pattern 7 — Rust extension gems

Modern gems with Rust extensions use `rb_sys` + `cargo`. They need:

1. **`rustc`, `cargo`, `libclang`** in deps
2. **`CARGO_HOME`** writable dir (sandbox has no home)
3. **`LIBCLANG_PATH`** for bindgen
4. **`BINDGEN_EXTRA_CLANG_ARGS`** pointing at GCC system headers
5. **`GEM_PATH`** including the `rb_sys` gem

```nix
# Template for Rust gems (tiktoken_ruby, tokenizers, etc.)
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ rustc cargo libclang ];
  buildGems = [ (buildGem "rb_sys") ];
  beforeBuild = ''
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
    export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.stdenv.cc.cc.version}/include"
  '';
}
```

**When cargo dependencies require a newer rustc than nixpkgs provides**, use a custom `buildPhase` that generates a lockfile and pins the offending crates before building:

```nix
# overlays/commonmarker.nix — pins darling/time for rustc 1.86 compat
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [ rustc cargo libclang ];
  buildGems = [ (buildGem "rb_sys") ];
  buildPhase = ''
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
    export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.stdenv.cc.cc.version}/include"

    for d in $(find ext -name Cargo.toml -not -path '*/target/*'); do
      dir=$(dirname "$d")
      (cd "$dir" && cargo generate-lockfile)
      # Pin crates to versions compatible with available rustc
      (cd "$dir" && cargo update darling --precise 0.20.10 2>&1 || true)
      (cd "$dir" && cargo update time --precise 0.3.36 2>&1 || true)
    done

    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES)
    done

    for makefile in $(find ext -name Makefile 2>/dev/null); do
      dir=$(dirname "$makefile")
      target_name=$(sed -n 's/^TARGET = //p' "$makefile")
      target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
      if [ -n "$target_name" ] && [ -f "$dir/$target_name.so" ]; then
        mkdir -p "lib$target_prefix"
        cp "$dir/$target_name.so" "lib$target_prefix/$target_name.so"
      fi
    done
  '';
}
```

**Why `buildPhase` instead of `beforeBuild` for crate pinning:** The lockfile must exist before `make` calls `cargo rustc`. With `beforeBuild`, the lockfile is generated, but `ruby extconf.rb` may regenerate it. A custom `buildPhase` gives you full control over the sequence: generate lockfile → pin crates → extconf → make.

### Pattern 8 — C++ standard mismatch

Older gem versions hardcode `-std=c++11` but link against libraries (like ICU 76+) that require C++17.

```nix
# overlays/charlock_holmes.nix
{ pkgs, ruby }:
{
  deps = with pkgs; [ icu zlib pkg-config which ];
  beforeBuild = ''
    find ext -name extconf.rb -exec sed -i 's/-std=c++11/-std=c++17/g' {} +
  '';
}
```

### Pattern 9 — Skip unbuildable gems

Some gems are abandoned, incompatible with the current Ruby, or have unsatisfiable build requirements. Produce an empty output with a message:

```nix
# overlays/debase.nix — incompatible with Ruby 3.4
{ pkgs, ruby }:
{
  deps = [ ];
  buildPhase = ''
    echo "debase: skipping build (incompatible with Ruby 3.4, use debug gem instead)"
  '';
}
```

```nix
# overlays/therubyracer.nix — abandoned
{ pkgs, ruby }:
{
  deps = [ ];
  buildPhase = ''
    echo "therubyracer: skipping build (abandoned gem, use mini_racer instead)"
  '';
}
```

### Pattern 10 — Replace vendored source with system library

When a gem ships broken or outdated vendored C code, replace it with the system library:

```nix
# overlays/hiredis.nix — vendored hiredis is broken, use system lib
{ pkgs, ruby }:
let hiredis-c = pkgs.hiredis; in
{
  deps = [ hiredis-c ];
  buildPhase = ''
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      rm -rf vendor/hiredis
      mkdir -p vendor/hiredis
      cp -r ${hiredis-c}/include/hiredis/* vendor/hiredis/
      cp ${hiredis-c}/lib/libhiredis.a vendor/hiredis/
      # Patch extconf to skip vendored make
      sed -i 's/success = system.*make.*/success = true/' "$dir/extconf.rb"
      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES) || true
    done
    for makefile in $(find ext -name Makefile 2>/dev/null); do
      dir=$(dirname "$makefile")
      target_name=$(sed -n 's/^TARGET = //p' "$makefile")
      target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
      if [ -n "$target_name" ] && [ -f "$dir/$target_name.so" ]; then
        mkdir -p "lib$target_prefix"
        cp "$dir/$target_name.so" "lib$target_prefix/$target_name.so"
      fi
    done
  '';
}
```

---

## Rules

1. **Never hand-edit files under `nix/`.** They are overwritten by `onix generate`. All customization goes in `overlays/`.
2. **Always use system libraries.** Never let a gem link against its own vendored copy of libxml2, sqlite, openssl, etc. Pass `--use-system-libraries` or equivalent flags.
3. **Always include `pkg-config`** when the gem uses pkg-config in its extconf.
4. **Use `buildGem` for gem deps** — not `callPackage` with hardcoded paths.
5. **Run `onix build` then `onix check`** after writing or changing an overlay.
6. **Prefer hooks (`beforeBuild`, `extconfFlags`, `buildGems`) over `buildPhase`** — hooks compose with the default build loop. Only use `buildPhase` when the default loop won't work.
7. **Escape `${` as `''${` in Nix strings** when you need a literal shell variable expansion.

## Nix String Escaping Quick Reference

Inside Nix `'' ... ''` multi-line strings:
- `''${VAR}` → literal `${VAR}` (shell expansion at runtime)
- `${expr}` → Nix interpolation (evaluated at build time)
- `'''` → literal `''`

Example:
```nix
beforeBuild = ''
  export FOO="''${FOO:-default}"          # shell: ${FOO:-default}
  export BAR="${pkgs.openssl}/lib"         # nix interpolation
'';
```
