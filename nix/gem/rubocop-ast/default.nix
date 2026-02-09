#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-ast
#
# Available versions:
#   1.44.1
#   1.48.0
#
# Usage:
#   rubocop-ast { version = "1.48.0"; }
#   rubocop-ast { }  # latest (1.48.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.48.0",
  git ? { },
}:
let
  versions = {
    "1.44.1" = import ./1.44.1 { inherit lib stdenv ruby; };
    "1.48.0" = import ./1.48.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-ast: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-ast: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
