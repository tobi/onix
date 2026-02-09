#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mocha
#
# Available versions:
#   2.8.2
#   3.0.1
#
# Usage:
#   mocha { version = "3.0.1"; }
#   mocha { }  # latest (3.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.1",
  git ? { },
}:
let
  versions = {
    "2.8.2" = import ./2.8.2 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mocha: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mocha: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
