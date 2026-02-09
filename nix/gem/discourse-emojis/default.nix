#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-emojis
#
# Available versions:
#   1.0.44
#
# Usage:
#   discourse-emojis { version = "1.0.44"; }
#   discourse-emojis { }  # latest (1.0.44)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.44",
  git ? { },
}:
let
  versions = {
    "1.0.44" = import ./1.0.44 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse-emojis: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "discourse-emojis: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
