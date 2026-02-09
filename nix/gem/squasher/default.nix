#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# squasher
#
# Available versions:
#   0.7.2
#
# Usage:
#   squasher { version = "0.7.2"; }
#   squasher { }  # latest (0.7.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.2",
  git ? { },
}:
let
  versions = {
    "0.7.2" = import ./0.7.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "squasher: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "squasher: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
