#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parser
#
# Available versions:
#   3.3.8.0
#   3.3.10.0
#
# Usage:
#   parser { version = "3.3.10.0"; }
#   parser { }  # latest (3.3.10.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.10.0",
  git ? { },
}:
let
  versions = {
    "3.3.8.0" = import ./3.3.8.0 { inherit lib stdenv ruby; };
    "3.3.10.0" = import ./3.3.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "parser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "parser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
