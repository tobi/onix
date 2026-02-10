# idn-ruby — needs libidn
{ pkgs, ruby, ... }:
with pkgs;
[
  libidn
  pkg-config
]
