# ffi-yajl — needs yajl headers + libyajl2 gem for the Ruby helper module
{ pkgs, ruby }:
{
  deps = with pkgs; [
    yajl
    pkg-config
  ];
  buildGems = [
    (pkgs.callPackage ../nix/gem/libyajl2/2.1.0 { inherit ruby; })
  ];
}
