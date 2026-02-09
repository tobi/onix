# Synthetic test app — git gems (rails) + native extensions (sqlite3, nokogiri, puma)
#
# Usage:
#   cd tests/synthetic && nix-shell devshell.nix
#
{ pkgs ? import <nixpkgs> {}
, ruby ? pkgs.ruby_3_4
}:

let
  resolve = import ../../nix/modules/resolve.nix;
  gems = resolve { inherit pkgs ruby; gemset = { gem.app.synthetic.enable = true; }; };
  bundlePath = pkgs.buildEnv {
    name = "synthetic-bundle-path";
    paths = builtins.attrValues gems;
  };
in pkgs.mkShell {
  name = "synthetic-devshell";

  buildInputs = [
    ruby
    pkgs.sqlite
    pkgs.libyaml
    pkgs.openssl
    pkgs.zlib
  ];

  shellHook = ''
    export BUNDLE_PATH="${bundlePath}"
    export BUNDLE_GEMFILE="${builtins.toString ./.}/Gemfile"

    echo "synthetic devshell ready — ${bundlePath}"
    echo "  ruby: $(ruby --version)"
    echo "  gems: $(ls ${bundlePath}/ruby/3.4.0/gems 2>/dev/null | wc -l)"
    echo "  git checkouts: $(ls ${bundlePath}/ruby/3.4.0/bundler/gems 2>/dev/null | wc -l)"
  '';
}
