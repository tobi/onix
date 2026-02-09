#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# colored2
#
# Available versions:
#   4.0.3
#
# Usage:
#   colored2 { version = "4.0.3"; }
#   colored2 { }  # latest (4.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.3",
  git ? { },
}:
let
  versions = {
    "4.0.3" = import ./4.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "colored2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "colored2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
