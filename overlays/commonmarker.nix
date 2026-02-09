# commonmarker — Rust extension via rb_sys, needs cargo/rustc + clang for bindgen
{ pkgs, ruby }:
let
  rb_sys = pkgs.callPackage ../nix/gem/rb_sys/0.9.124 { inherit ruby; };
in
{
  deps = with pkgs; [
    rustc
    cargo
    libclang
  ];
  beforeBuild = ''
    export GEM_PATH=${rb_sys}/${rb_sys.prefix}
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
    export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.stdenv.cc.cc.version}/include"

    # Pin darling to 0.20.x if 0.23+ is resolved (requires rustc >= 1.88)
    for d in $(find ext -name Cargo.toml -not -path '*/target/*'); do
      dir=$(dirname "$d")
      if [ ! -f "$dir/Cargo.lock" ]; then
        (cd "$dir" && cargo generate-lockfile 2>/dev/null || true)
      fi
      if [ -f "$dir/Cargo.lock" ] && grep -q 'name = "darling"' "$dir/Cargo.lock" 2>/dev/null; then
        darling_ver=$(grep -A1 'name = "darling"' "$dir/Cargo.lock" | grep version | head -1 | sed 's/.*"\(.*\)".*/\1/')
        if [ "''${darling_ver%%.*}" = "0" ] && [ "''${darling_ver#0.}" != "''${darling_ver}" ]; then
          minor=$(echo "$darling_ver" | cut -d. -f2)
          if [ "$minor" -ge 23 ] 2>/dev/null; then
            echo "Pinning darling $darling_ver -> 0.20.10 for rustc compatibility"
            (cd "$dir" && cargo update darling@$darling_ver --precise 0.20.10 2>/dev/null || true)
            (cd "$dir" && cargo update darling_core@$darling_ver --precise 0.20.10 2>/dev/null || true)
            (cd "$dir" && cargo update darling_macro@$darling_ver --precise 0.20.10 2>/dev/null || true)
          fi
        fi
      fi
    done
  '';
}
