# mysql2 — needs mysql/mariadb client library + openssl
{ pkgs, ruby, ... }:
with pkgs;
[
  libmysqlclient
  openssl
  pkg-config
  zlib
]
