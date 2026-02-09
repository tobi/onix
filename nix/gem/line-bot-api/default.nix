#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# line-bot-api
#
# Available versions:
#   1.28.0
#
# Usage:
#   line-bot-api { version = "1.28.0"; }
#   line-bot-api { }  # latest (1.28.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.28.0",
  git ? { },
}:
let
  versions = {
    "1.28.0" = import ./1.28.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "line-bot-api: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "line-bot-api: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
