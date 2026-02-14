# rmagick — ImageMagick + pkg-config Ruby gem at build time
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [
    imagemagick
    pkg-config
  ];
  buildGems = [
    (buildGem "pkg-config")
  ];
}
