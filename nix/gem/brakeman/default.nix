#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# brakeman
#
# Available versions:
#   5.4.1
#   7.1.2
#
# Usage:
#   brakeman { version = "7.1.2"; }
#   brakeman { }  # latest (7.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.2",
  git ? { },
}:
let
  versions = {
    "5.4.1" = import ./5.4.1 { inherit lib stdenv ruby; };
    "7.1.2" = import ./7.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "brakeman: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "brakeman: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
