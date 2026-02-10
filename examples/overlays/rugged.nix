# rugged — needs cmake to build vendored libgit2
{ pkgs, ruby, ... }:
with pkgs;
[
  cmake
  pkg-config
  openssl
  zlib
  libssh2
]
