# Dev shell for fizzy with all gems pre-built via scint-to-nix.
#
# Usage:
#   cd fizzy && nix-shell ../scint-to-nix/tests/fizzy/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  bundlePath = import ../../out/gems/bundle-path.nix { inherit pkgs ruby; };
  rubyApiVersion = builtins.elemAt (builtins.attrNames (builtins.readDir "${bundlePath}/ruby")) 0;
  gemDir = "${bundlePath}/ruby/${rubyApiVersion}";
in pkgs.mkShell {
  name = "fizzy-devshell";

  buildInputs = [
    ruby
    pkgs.sqlite
    pkgs.libyaml
    pkgs.openssl
    pkgs.zlib
    pkgs.pkg-config
    pkgs.vips
  ];

  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="$PWD/Gemfile"
    export GEM_PATH="${gemDir}"
    export GEM_HOME="${gemDir}"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    echo "fizzy devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${gemDir}/gems 2>/dev/null | wc -l)"
    echo "  git checkouts: $(ls ${gemDir}/bundler/gems 2>/dev/null | wc -l)"
  '';
}
