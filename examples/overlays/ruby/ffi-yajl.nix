# ffi-yajl — needs yajl headers + libyajl2 gem for the Ruby helper module
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [
    yajl
    pkg-config
  ];
  buildGems = [
    (buildGem "libyajl2")
  ];
}
