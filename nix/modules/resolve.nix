#
# resolve.nix — turn a gemset config into an attrset of built derivations
#
# A gemset is a list of entries, each either:
#   { name = "rack"; version = "3.2.4"; }
#   { name = "rails"; git = { rev = "60d92e4e7dfe"; }; }
#
# Usage:
#   resolve = import ./nix/modules/resolve.nix;
#   gems = resolve {
#     inherit pkgs ruby;
#     gemset = import ./nix/app/fizzy.nix;
#   };
#   builtins.attrValues gems  -> list of derivations
#
{ pkgs, ruby, gemset }:

let
  inherit (pkgs) lib stdenv;
  gem =
    name: args:
    import (../gem + "/${name}") (
      {
        inherit
          lib
          stdenv
          ruby
          pkgs
          ;
      }
      // args
    );

  resolve = entry:
    if entry ? git then {
      name = "${entry.name}-${entry.git.rev}";
      value = gem entry.name { git = entry.git; };
    } else {
      name = entry.name;
      value = gem entry.name { version = entry.version; };
    };
in
builtins.listToAttrs (map resolve gemset)
