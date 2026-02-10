{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.rails.enable = true; }; };
in gems.devShell {
  name = "rails-devshell";
  buildInputs = with pkgs; [
    sqlite postgresql
    vips imagemagick libyaml openssl zlib pkg-config libffi git
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  '';
}
