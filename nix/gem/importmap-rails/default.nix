#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# importmap-rails
#
# Available versions:
#   2.2.2
#
# Usage:
#   importmap-rails { version = "2.2.2"; }
#   importmap-rails { }  # latest (2.2.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.2",
  git ? { },
}:
let
  versions = {
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "importmap-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "importmap-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
