# nokogiri — system libxml2/libxslt, needs mini_portile2 at build time
{ pkgs, ruby }:
{
  deps = with pkgs; [
    libxml2
    libxslt
    pkg-config
    zlib
  ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; })
  ];
}
