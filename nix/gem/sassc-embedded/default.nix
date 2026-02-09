#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sassc-embedded
#
# Available versions:
#   1.80.5
#
# Usage:
#   sassc-embedded { version = "1.80.5"; }
#   sassc-embedded { }  # latest (1.80.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.80.5",
  git ? { },
}:
let
  versions = {
    "1.80.5" = import ./1.80.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sassc-embedded: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sassc-embedded: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
