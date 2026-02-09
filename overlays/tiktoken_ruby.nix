# tiktoken_ruby: OpenAI's BPE tokenizer (Rust extension via rb_sys)
#
# Build-time requirements:
#   - rb_sys gem on GEM_PATH (provides create_rust_makefile for extconf.rb)
#   - Rust toolchain (rustc + cargo)
#   - Vendored cargo dependencies (no network in nix sandbox)
#
# The extconf.rb does:
#   require 'rb_sys/mkmf'
#   create_rust_makefile('tiktoken_ruby/tiktoken_ruby')
#
# rb_sys generates a Makefile that invokes `cargo rustc` to build the cdylib,
# then copies the .so into place. We vendor the cargo deps and configure
# .cargo/config.toml to point at them.
#
{ pkgs, ruby }:
let
  rb_sys = pkgs.callPackage ../nix/gem/rb_sys/0.9.119 { inherit ruby; };
  cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
    src = ../cache/sources/tiktoken_ruby-0.0.15.1;
    hash = "sha256-zyGK+XJpMls6w0Uydegqsj4TH4IrVxANm0qmpR7+95I=";
  };
in
{
  deps = with pkgs; [ rustPlatform.rust.cargo rustPlatform.rust.rustc pkg-config llvmPackages.libclang ];
  beforeBuild = ''
    export GEM_PATH=${rb_sys}/${rb_sys.prefix}

    # Point cargo at the vendored dependencies
    mkdir -p .cargo
    sed "s|@vendor@|${cargoDeps}|" ${cargoDeps}/.cargo/config.toml > .cargo/config.toml

    # bindgen needs libclang
    export LIBCLANG_PATH="${pkgs.llvmPackages.libclang.lib}/lib"
  '';
}
