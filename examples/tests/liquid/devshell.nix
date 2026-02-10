# Liquid dev/test shell — pure Ruby library, minimal deps.
#
# Usage:
#   cd ~/src/ruby-tests/liquid && nix-shell ../../tries/2026-02-07-scint/gemset2nix/tests/liquid/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.liquid.enable = true; }; };
  bundlePath = pkgs.buildEnv {
    name = "liquid-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "liquid-devshell";

  buildInputs = [
    ruby
    pkgs.libyaml
    pkgs.openssl
    pkgs.zlib
    pkgs.pkg-config
  ];

  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="$PWD/Gemfile"

    echo "liquid devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.4.0/gems 2>/dev/null | wc -l)"
  '';
}
