{ pkgs, ruby, ... }:
{
  deps = with pkgs; [
    sqlite
    pkg-config
  ];
  extconfFlags = "--enable-system-libraries";
}
