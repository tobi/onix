# gpgme — system gpgme + mini_portile2 at build time
{ pkgs, ruby }:
{
  deps = with pkgs; [
    gpgme
    libgpg-error
    libassuan
    pkg-config
  ];
  extconfFlags = "--use-system-libraries";
  buildGems = [
    (pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; })
  ];
  beforeBuild = ''
    export RUBY_GPGME_USE_SYSTEM_LIBRARIES=1
  '';
}
