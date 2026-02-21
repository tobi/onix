# nokogiri — system libxml2/libxslt, needs mini_portile2 at build time
{
  pkgs,
  ruby,
  buildGem,
  ...
}:
{
  deps = with pkgs; [
    libxml2
    libxslt
    pkg-config
    zlib
  ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (buildGem "mini_portile2")
  ];
}
