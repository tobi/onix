#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bcrypt
#
# Available versions:
#   3.1.20
#   3.1.21
#
# Usage:
#   bcrypt { version = "3.1.21"; }
#   bcrypt { }  # latest (3.1.21)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.21",
  git ? { },
}:
let
  versions = {
    "3.1.20" = import ./3.1.20 { inherit lib stdenv ruby; };
    "3.1.21" = import ./3.1.21 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bcrypt: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "bcrypt: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
