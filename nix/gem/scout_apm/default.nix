#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# scout_apm
#
# Available versions:
#   5.3.3
#
# Usage:
#   scout_apm { version = "5.3.3"; }
#   scout_apm { }  # latest (5.3.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.3",
  git ? { },
}:
let
  versions = {
    "5.3.3" = import ./5.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "scout_apm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "scout_apm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
