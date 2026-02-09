#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# annotaterb
#
# Available versions:
#   4.20.0
#
# Usage:
#   annotaterb { version = "4.20.0"; }
#   annotaterb { }  # latest (4.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.20.0",
  git ? { },
}:
let
  versions = {
    "4.20.0" = import ./4.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "annotaterb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "annotaterb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
