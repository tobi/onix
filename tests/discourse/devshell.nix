# Discourse dev/test shell.
#
# Usage:
#   cd ~/src/ruby-tests/discourse && nix-shell ../../tries/2026-02-07-scint/scint-to-nix/tests/discourse/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_3
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = import ../../nix/app/discourse.nix; };
  bundlePath = pkgs.buildEnv {
    name = "discourse-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "discourse-devshell";

  buildInputs = [
    ruby
    (pkgs.postgresql.withPackages (ps: [ ps.pgvector ]))
    pkgs.redis
    pkgs.nodejs_22
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

    echo "discourse devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.3.0/gems 2>/dev/null | wc -l)"
  '';
}
