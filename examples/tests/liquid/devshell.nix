{
  pkgs ? import <nixpkgs> { },
  ruby ? pkgs.ruby_3_4,
}:
let
  project = import ../../nix/liquid.nix { inherit pkgs ruby; };
in
project.devShell {
  name = "liquid-devshell";
  buildInputs = with pkgs; [
    libyaml
    openssl
    zlib
    pkg-config
  ];
}
