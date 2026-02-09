# rmagick — needs ImageMagick + pkg-config ruby gem at build time
{ pkgs, ruby }:
let
  pkg-config-gem = pkgs.callPackage ../nix/gem/pkg-config/1.6.3 { inherit ruby; };
in
{
  deps = with pkgs; [
    imagemagick
    pkg-config
  ];
  beforeBuild = ''
    export GEM_PATH=${pkg-config-gem}/${pkg-config-gem.bundle_path}
  '';
}
