#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ast
#
# Available versions:
#   2.4.3
#
# Usage:
#   ast { version = "2.4.3"; }
#   ast { }  # latest (2.4.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.3",
  git ? { },
}:
let
  versions = {
    "2.4.3" = import ./2.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ast: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ast: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
