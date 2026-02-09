{ pkgs, ruby }:
let
  mini_portile2 = pkgs.callPackage ../nix/gem/mini_portile2/2.8.9 { inherit ruby; };
in
{
  deps = with pkgs; [
    libxml2
    libxslt
    pkg-config
    zlib
  ];
  extconfFlags = "--use-system-libraries";
  beforeBuild = ''
    export GEM_PATH=${mini_portile2}/${mini_portile2.bundle_path}
  '';
}
