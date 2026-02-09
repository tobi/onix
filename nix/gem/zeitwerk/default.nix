#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zeitwerk
#
# Available versions:
#   2.6.17
#   2.7.3
#   2.7.4
#
# Usage:
#   zeitwerk { version = "2.7.4"; }
#   zeitwerk { }  # latest (2.7.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.4",
  git ? { },
}:
let
  versions = {
    "2.6.17" = import ./2.6.17 { inherit lib stdenv ruby; };
    "2.7.3" = import ./2.7.3 { inherit lib stdenv ruby; };
    "2.7.4" = import ./2.7.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "zeitwerk: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "zeitwerk: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
