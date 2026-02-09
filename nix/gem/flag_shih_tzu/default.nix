#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flag_shih_tzu
#
# Available versions:
#   0.3.23
#
# Usage:
#   flag_shih_tzu { version = "0.3.23"; }
#   flag_shih_tzu { }  # latest (0.3.23)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.23",
  git ? { },
}:
let
  versions = {
    "0.3.23" = import ./0.3.23 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flag_shih_tzu: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "flag_shih_tzu: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
