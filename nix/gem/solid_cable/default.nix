#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cable
#
# Available versions:
#   3.0.12
#
# Usage:
#   solid_cable { version = "3.0.12"; }
#   solid_cable { }  # latest (3.0.12)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.12",
  git ? { },
}:
let
  versions = {
    "3.0.12" = import ./3.0.12 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solid_cable: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "solid_cable: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
