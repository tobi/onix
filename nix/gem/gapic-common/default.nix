#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gapic-common
#
# Available versions:
#   0.20.0
#
# Usage:
#   gapic-common { version = "0.20.0"; }
#   gapic-common { }  # latest (0.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.0",
  git ? { },
}:
let
  versions = {
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gapic-common: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gapic-common: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
