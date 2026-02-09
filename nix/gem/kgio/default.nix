#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kgio
#
# Available versions:
#   2.11.4
#
# Usage:
#   kgio { version = "2.11.4"; }
#   kgio { }  # latest (2.11.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.11.4",
  git ? { },
}:
let
  versions = {
    "2.11.4" = import ./2.11.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kgio: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "kgio: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
