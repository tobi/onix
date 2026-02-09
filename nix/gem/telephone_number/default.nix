#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# telephone_number
#
# Available versions:
#   1.4.20
#
# Usage:
#   telephone_number { version = "1.4.20"; }
#   telephone_number { }  # latest (1.4.20)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.20",
  git ? { },
}:
let
  versions = {
    "1.4.20" = import ./1.4.20 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "telephone_number: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "telephone_number: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
