#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass-embedded
#
# Available versions:
#   1.91.0
#
# Usage:
#   sass-embedded { version = "1.91.0"; }
#   sass-embedded { }  # latest (1.91.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.91.0",
  git ? { },
}:
let
  versions = {
    "1.91.0" = import ./1.91.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sass-embedded: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sass-embedded: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
