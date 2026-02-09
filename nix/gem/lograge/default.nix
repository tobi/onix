#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lograge
#
# Available versions:
#   0.14.0
#
# Usage:
#   lograge { version = "0.14.0"; }
#   lograge { }  # latest (0.14.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.14.0",
  git ? { },
}:
let
  versions = {
    "0.14.0" = import ./0.14.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "lograge: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "lograge: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
