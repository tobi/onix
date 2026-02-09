#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# listen
#
# Available versions:
#   3.8.0
#   3.9.0
#
# Usage:
#   listen { version = "3.9.0"; }
#   listen { }  # latest (3.9.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.0",
  git ? { },
}:
let
  versions = {
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "listen: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "listen: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
