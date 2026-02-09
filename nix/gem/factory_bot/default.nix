#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot
#
# Available versions:
#   6.4.5
#
# Usage:
#   factory_bot { version = "6.4.5"; }
#   factory_bot { }  # latest (6.4.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.4.5",
  git ? { },
}:
let
  versions = {
    "6.4.5" = import ./6.4.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_bot: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "factory_bot: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
