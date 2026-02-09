# gpgme — needs mini_portile2 at build time + gpgme system lib
# Use --use-system-libraries to avoid downloading dependencies in sandbox
{ pkgs, ruby }:
let
  mini_portile2 = pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; };
in
{
  deps = with pkgs; [
    gpgme
    libgpg-error
    libassuan
    pkg-config
  ];
  extconfFlags = "--use-system-libraries";
  beforeBuild = ''
    export GEM_PATH=${mini_portile2}/${mini_portile2.bundle_path}
    export RUBY_GPGME_USE_SYSTEM_LIBRARIES=1
  '';
}
