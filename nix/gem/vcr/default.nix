#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vcr
#
# Available versions:
#   6.4.0
#
# Usage:
#   vcr { version = "6.4.0"; }
#   vcr { }  # latest (6.4.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.4.0",
  git ? { },
}:
let
  versions = {
    "6.4.0" = import ./6.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vcr: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "vcr: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
