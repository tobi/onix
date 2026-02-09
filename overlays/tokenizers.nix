# tokenizers: HuggingFace tokenizers bindings (Rust extension via rb_sys)
#
# Build-time requirements:
#   - rb_sys gem on GEM_PATH (provides create_rust_makefile for extconf.rb)
#   - Rust toolchain (rustc + cargo)
#   - Vendored cargo dependencies (no network in nix sandbox)
#   - System oniguruma (the onig_sys crate finds it via pkg-config when
#     RUSTONIG_SYSTEM_LIBONIG=1 is set)
#
# The extconf.rb does:
#   require 'rb_sys/mkmf'
#   create_rust_makefile('tokenizers/tokenizers')
#
{ pkgs, ruby }:
let
  rb_sys = pkgs.callPackage ../nix/gem/rb_sys/0.9.119 { inherit ruby; };
  cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
    src = ../cache/sources/tokenizers-0.6.3;
    hash = "sha256-Yxcerq4Wil1nrEzHoEmsTAj4VnUmrwRlA3WO2b72yOc=";
  };
in
{
  deps = with pkgs; [
    rustPlatform.rust.cargo
    rustPlatform.rust.rustc
    pkg-config
    llvmPackages.libclang
    oniguruma   # system oniguruma for the onig_sys crate
  ];
  beforeBuild = ''
    export GEM_PATH=${rb_sys}/${rb_sys.prefix}

    # Point cargo at the vendored dependencies
    mkdir -p .cargo
    sed "s|@vendor@|${cargoDeps}|" ${cargoDeps}/.cargo/config.toml > .cargo/config.toml

    # bindgen needs libclang
    export LIBCLANG_PATH="${pkgs.llvmPackages.libclang.lib}/lib"

    # Tell onig_sys to use system oniguruma instead of bundling its own
    export RUSTONIG_SYSTEM_LIBONIG=1
  '';
}
