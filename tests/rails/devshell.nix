# Rails framework dev/test shell — for testing the rails repo itself.
#
# Usage:
#   cd ~/src/ruby-tests/rails && nix-shell ../../tries/2026-02-07-scint/gemset2nix/tests/rails/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.rails.enable = true; }; };
  bundlePath = pkgs.buildEnv {
    name = "rails-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "rails-devshell";

  buildInputs = [
    ruby
    pkgs.sqlite
    pkgs.postgresql
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

    echo "rails devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.4.0/gems 2>/dev/null | wc -l)"
  '';
}
