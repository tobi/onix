{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  project = import ../../nix/redmine.nix { inherit pkgs ruby; };
in project.devShell {
  name = "redmine-devshell";
  buildInputs = with pkgs; [
    sqlite imagemagick libyaml openssl zlib pkg-config libffi git
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    rm -rf tmp/cache/bootsnap 2>/dev/null
  '';
}
