#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop
#
# Available versions:
#   1.75.6
#   1.81.7
#
# Usage:
#   rubocop { version = "1.81.7"; }
#   rubocop { }  # latest (1.81.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.81.7",
  git ? { },
}:
let
  versions = {
    "1.75.6" = import ./1.75.6 { inherit lib stdenv ruby; };
    "1.81.7" = import ./1.81.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
