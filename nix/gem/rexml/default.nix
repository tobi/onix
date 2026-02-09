#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rexml
#
# Available versions:
#   3.4.4
#
# Usage:
#   rexml { version = "3.4.4"; }
#   rexml { }  # latest (3.4.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.4",
  git ? { },
}:
let
  versions = {
    "3.4.4" = import ./3.4.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rexml: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rexml: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
