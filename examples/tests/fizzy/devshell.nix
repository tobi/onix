{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  project = import ../../nix/fizzy.nix { inherit pkgs ruby; };
in project.devShell {
  name = "fizzy-devshell";
  buildInputs = with pkgs; [ sqlite libyaml openssl zlib pkg-config vips ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    rm -rf tmp/cache/bootsnap 2>/dev/null
  '';
}
