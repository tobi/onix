{
  pkgs ? import <nixpkgs> { },
  ruby ? pkgs.ruby_3_4,
}:
let
  project = import ../../nix/synthetic.nix { inherit pkgs ruby; };
in
project.devShell {
  name = "synthetic-devshell";
  buildInputs = with pkgs; [
    sqlite
    libyaml
    openssl
    zlib
  ];
  shellHook = ''
    export BUNDLE_GEMFILE="${builtins.toString ./.}/Gemfile"
  '';
}
