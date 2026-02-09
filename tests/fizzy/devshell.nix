# Dev shell for fizzy with all gems pre-built via scint-to-nix.
#
# Usage:
#   cd fizzy && nix-shell ../scint-to-nix/tests/fizzy/devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = import ../../nix/app/fizzy.nix; };
  bundlePath = pkgs.buildEnv {
    name = "fizzy-bundle-path";
    paths = builtins.attrValues gems;
  };
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
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips pkgs.libffi ]}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

    # Clear stale bootsnap cache (symlink resolution differs from non-nix installs)
    rm -rf tmp/cache/bootsnap 2>/dev/null

    echo "fizzy devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.4.0/gems 2>/dev/null | wc -l)"
    echo "  git checkouts: $(ls ${bundlePath}/ruby/3.4.0/bundler/gems 2>/dev/null | wc -l)"
  '';
}
