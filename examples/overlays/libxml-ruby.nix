# libxml-ruby — needs libxml2 headers and xml2-config
{ pkgs, ruby, ... }:
{
  deps = with pkgs; [
    libxml2
    pkg-config
  ];
  beforeBuild = ''
    export C_INCLUDE_PATH="${pkgs.libxml2.dev}/include/libxml2''${C_INCLUDE_PATH:+:$C_INCLUDE_PATH}"
  '';
}
