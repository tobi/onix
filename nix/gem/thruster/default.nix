#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thruster
#
# Available versions:
#   0.1.17
#
# Usage:
#   thruster { version = "0.1.17"; }
#   thruster { }  # latest (0.1.17)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.17",
  git ? { },
}:
let
  versions = {
    "0.1.17" = import ./0.1.17 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thruster: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "thruster: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
