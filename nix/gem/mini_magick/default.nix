#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_magick
#
# Available versions:
#   4.12.0
#   5.3.1
#
# Usage:
#   mini_magick { version = "5.3.1"; }
#   mini_magick { }  # latest (5.3.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.1",
  git ? { },
}:
let
  versions = {
    "4.12.0" = import ./4.12.0 { inherit lib stdenv ruby; };
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_magick: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mini_magick: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
