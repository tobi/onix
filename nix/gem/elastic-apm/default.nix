#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elastic-apm
#
# Available versions:
#   4.6.2
#
# Usage:
#   elastic-apm { version = "4.6.2"; }
#   elastic-apm { }  # latest (4.6.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.6.2",
  git ? { },
}:
let
  versions = {
    "4.6.2" = import ./4.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elastic-apm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "elastic-apm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
