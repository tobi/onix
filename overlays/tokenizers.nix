# tokenizers — Rust extension via rb_sys, needs cargo + clang for bindgen
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
    export GEM_PATH=${rb_sys}/${rb_sys.bundle_path}
    export CARGO_HOME="$TMPDIR/cargo"
    mkdir -p "$CARGO_HOME"
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib"
    export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.stdenv.hostPlatform.config}/${pkgs.stdenv.cc.cc.version}/include"
  '';
}
