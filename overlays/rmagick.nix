# rmagick — ImageMagick + pkg-config Ruby gem at build time
{ pkgs, ruby }:
{
  deps = with pkgs; [
    imagemagick
    pkg-config
  ];
  buildGems = [
    (pkgs.callPackage ../nix/gem/pkg-config/1.6.3 { inherit ruby; })
  ];
}
