#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# addressable
#
# Available versions:
#   2.8.7
#   2.8.8
#
# Usage:
#   addressable { version = "2.8.8"; }
#   addressable { }  # latest (2.8.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.8",
  git ? { },
}:
let
  versions = {
    "2.8.7" = import ./2.8.7 { inherit lib stdenv ruby; };
    "2.8.8" = import ./2.8.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "addressable: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "addressable: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
