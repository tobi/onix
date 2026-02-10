# hiredis-client — needs openssl for SSL support
{ pkgs, ruby, ... }:
with pkgs;
[
  openssl
  pkg-config
]
