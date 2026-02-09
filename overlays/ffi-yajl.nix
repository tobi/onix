# ffi-yajl — needs yajl headers + libyajl2 gem for the Ruby helper module
{ pkgs, ruby }:
let
  libyajl2 = pkgs.callPackage ../nix/gem/libyajl2/2.1.0 { inherit ruby; };
in
{
  deps = with pkgs; [
    yajl
    pkg-config
  ];
  beforeBuild = ''
    export GEM_PATH=${libyajl2}/${libyajl2.bundle_path}
  '';
}
