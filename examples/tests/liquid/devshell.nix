{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:
let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; config = { deps.gem.app.liquid.enable = true; }; };
in gems.devShell {
  name = "liquid-devshell";
  buildInputs = with pkgs; [ libyaml openssl zlib pkg-config ];
}
