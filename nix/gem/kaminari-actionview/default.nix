#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kaminari-actionview
#
# Available versions:
#   1.2.2
#
# Usage:
#   kaminari-actionview { version = "1.2.2"; }
#   kaminari-actionview { }  # latest (1.2.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.2",
  git ? { },
}:
let
  versions = {
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kaminari-actionview: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "kaminari-actionview: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
