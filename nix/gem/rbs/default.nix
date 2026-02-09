#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbs
#
# Available versions:
#   3.9.5
#
# Usage:
#   rbs { version = "3.9.5"; }
#   rbs { }  # latest (3.9.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.5",
  git ? { },
}:
let
  versions = {
    "3.9.5" = import ./3.9.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rbs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
