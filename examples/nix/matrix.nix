#
# matrix.nix — build matrix: rubies × apps
#
# Returns a nested attrset: { <ruby>.<app> = bundle-path derivation; }
#
# Usage:
#   nix-build nix/matrix.nix -A ruby_3_4.fizzy   # one app, one ruby
#   nix-build nix/matrix.nix -A ruby_3_4          # all apps, one ruby
#   nix-build nix/matrix.nix                      # full matrix
#
{
  pkgs ? import <nixpkgs> { },
  rubies ? {
    inherit (pkgs)
      ruby_3_1
      ruby_3_2
      ruby_3_3
      ruby_3_4
      ;
    ruby_4_0 = import ./ruby4.nix { inherit pkgs; };
  },
  apps ? [
    "fizzy"
    "chatwoot"
    "discourse"
  ],
}:

let
  resolve = import ./modules/resolve.nix;

  buildApp =
    rubyName: ruby: app:
    let
      gems = resolve {
        inherit pkgs ruby;
        gemset = import (./app + "/${app}.nix");
      };
    in
    pkgs.buildEnv {
      name = "${app}-${rubyName}";
      paths = builtins.attrValues gems;
    };

  buildRuby =
    rubyName: ruby:
    builtins.listToAttrs (
      map (app: {
        name = app;
        value = buildApp rubyName ruby app;
      }) (builtins.filter (app: builtins.pathExists (./app + "/${app}.nix")) apps)
    );

in
builtins.mapAttrs buildRuby rubies
