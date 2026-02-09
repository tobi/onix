#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# matrix
#
# Available versions:
#   0.4.3
#
# Usage:
#   matrix { version = "0.4.3"; }
#   matrix { }  # latest (0.4.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.3",
  git ? { },
}:
let
  versions = {
    "0.4.3" = import ./0.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "matrix: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "matrix: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
