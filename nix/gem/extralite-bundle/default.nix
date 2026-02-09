#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# extralite-bundle
#
# Available versions:
#   2.13
#
# Usage:
#   extralite-bundle { version = "2.13"; }
#   extralite-bundle { }  # latest (2.13)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.13",
  git ? { },
}:
let
  versions = {
    "2.13" = import ./2.13 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "extralite-bundle: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "extralite-bundle: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
