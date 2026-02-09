#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sawyer
#
# Available versions:
#   0.9.3
#
# Usage:
#   sawyer { version = "0.9.3"; }
#   sawyer { }  # latest (0.9.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.3",
  git ? { },
}:
let
  versions = {
    "0.9.3" = import ./0.9.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sawyer: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sawyer: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
