#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# date
#
# Available versions:
#   3.4.1
#   3.5.0
#   3.5.1
#
# Usage:
#   date { version = "3.5.1"; }
#   date { }  # latest (3.5.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.1",
  git ? { },
}:
let
  versions = {
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
    "3.5.1" = import ./3.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "date: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "date: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
