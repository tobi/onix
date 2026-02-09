# Redmine dev/test shell.
#
# Usage:
#   cd ~/src/ruby-tests/redmine && nix-shell ../../tries/2026-02-07-scint/scint-to-nix/tests/redmine/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = import ../../nix/app/redmine.nix; };
  bundlePath = pkgs.buildEnv {
    name = "redmine-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "redmine-devshell";

  buildInputs = [
    ruby
    pkgs.sqlite
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
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.imagemagick pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    rm -rf tmp/cache/bootsnap 2>/dev/null

    echo "redmine devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.4.0/gems 2>/dev/null | wc -l)"
  '';
}
