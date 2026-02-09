#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rinku
#
# Available versions:
#   2.0.6
#
# Usage:
#   rinku { version = "2.0.6"; }
#   rinku { }  # latest (2.0.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.6",
  git ? { },
}:
let
  versions = {
    "2.0.6" = import ./2.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rinku: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rinku: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
