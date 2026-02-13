# tiktoken_ruby — Rust extension via rb_sys
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [
    rustc
    cargo
    libclang
  ];
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
