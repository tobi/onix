#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tzinfo
#
# Available versions:
#   2.0.6
#
# Usage:
#   tzinfo { version = "2.0.6"; }
#   tzinfo { }  # latest (2.0.6)
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
    or (throw "tzinfo: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tzinfo: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
