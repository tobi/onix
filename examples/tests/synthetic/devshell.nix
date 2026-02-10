{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.synthetic.enable = true; }; };
in gems.devShell {
  name = "synthetic-devshell";
  buildInputs = with pkgs; [ sqlite libyaml openssl zlib ];
  shellHook = ''
    export BUNDLE_GEMFILE="${builtins.toString ./.}/Gemfile"
  '';
}
