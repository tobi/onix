#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-discourse
#
# Available versions:
#   3.13.3
#
# Usage:
#   rubocop-discourse { version = "3.13.3"; }
#   rubocop-discourse { }  # latest (3.13.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.3",
  git ? { },
}:
let
  versions = {
    "3.13.3" = import ./3.13.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-discourse: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-discourse: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
