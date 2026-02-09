#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fcm
#
# Available versions:
#   1.0.8
#
# Usage:
#   fcm { version = "1.0.8"; }
#   fcm { }  # latest (1.0.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.8",
  git ? { },
}:
let
  versions = {
    "1.0.8" = import ./1.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fcm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fcm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
