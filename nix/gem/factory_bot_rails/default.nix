#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot_rails
#
# Available versions:
#   6.4.3
#
# Usage:
#   factory_bot_rails { version = "6.4.3"; }
#   factory_bot_rails { }  # latest (6.4.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.4.3",
  git ? { },
}:
let
  versions = {
    "6.4.3" = import ./6.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "factory_bot_rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "factory_bot_rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
