#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-factory_bot
#
# Available versions:
#   2.27.1
#   2.28.0
#
# Usage:
#   rubocop-factory_bot { version = "2.28.0"; }
#   rubocop-factory_bot { }  # latest (2.28.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.28.0",
  git ? { },
}:
let
  versions = {
    "2.27.1" = import ./2.27.1 { inherit lib stdenv ruby; };
    "2.28.0" = import ./2.28.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-factory_bot: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-factory_bot: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
