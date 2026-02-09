#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# loofah
#
# Available versions:
#   2.23.1
#   2.24.1
#   2.25.0
#
# Usage:
#   loofah { version = "2.25.0"; }
#   loofah { }  # latest (2.25.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.25.0",
  git ? { },
}:
let
  versions = {
    "2.23.1" = import ./2.23.1 { inherit lib stdenv ruby; };
    "2.24.1" = import ./2.24.1 { inherit lib stdenv ruby; };
    "2.25.0" = import ./2.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "loofah: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "loofah: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
