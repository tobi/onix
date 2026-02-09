# Spree dev/test shell — SQLite for testing.
#
# Usage:
#   cd ~/src/ruby-tests/spree && nix-shell ../../tries/2026-02-07-scint/gemset2nix/tests/spree/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.spree.enable = true; }; };
  bundlePath = pkgs.buildEnv {
    name = "spree-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "spree-devshell";

  buildInputs = [
    ruby
    pkgs.sqlite
    pkgs.vips
    pkgs.imagemagick
    pkgs.libyaml
    pkgs.openssl
    pkgs.zlib
    pkgs.pkg-config
    pkgs.libffi
    pkgs.git
  ];

  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="$PWD/Gemfile"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    rm -rf tmp/cache/bootsnap 2>/dev/null

    echo "spree devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.4.0/gems 2>/dev/null | wc -l)"
  '';
}
