#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack
#
# Available versions:
#   2.2.21
#   3.2.3
#   3.2.4
#
# Usage:
#   rack { version = "3.2.4"; }
#   rack { }  # latest (3.2.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.4",
  git ? { },
}:
let
  versions = {
    "2.2.21" = import ./2.2.21 { inherit lib stdenv ruby; };
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
    "3.2.4" = import ./3.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
