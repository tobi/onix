# gpgme — system gpgme + mini_portile2 at build time
{ pkgs, ruby, buildGem, ... }:
{
  deps = with pkgs; [
    gpgme
    libgpg-error
    libassuan
    pkg-config
  ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (buildGem "mini_portile2")
  ];
  preBuild = ''
    export RUBY_GPGME_USE_SYSTEM_LIBRARIES=1
  '';
}
