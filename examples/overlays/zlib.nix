# zlib (ruby gem) — needs system zlib
{ pkgs, ruby }:
with pkgs;
[
  zlib
  pkg-config
]
