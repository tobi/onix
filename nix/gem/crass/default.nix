#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# crass
#
# Available versions:
#   1.0.6
#
# Usage:
#   crass { version = "1.0.6"; }
#   crass { }  # latest (1.0.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.6",
  git ? { },
}:
let
  versions = {
    "1.0.6" = import ./1.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "crass: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "crass: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
