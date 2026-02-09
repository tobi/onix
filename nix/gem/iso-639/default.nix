#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# iso-639
#
# Available versions:
#   0.3.8
#
# Usage:
#   iso-639 { version = "0.3.8"; }
#   iso-639 { }  # latest (0.3.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.8",
  git ? { },
}:
let
  versions = {
    "0.3.8" = import ./0.3.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "iso-639: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "iso-639: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
