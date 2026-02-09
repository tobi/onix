#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jwt
#
# Available versions:
#   2.10.1
#   3.1.2
#
# Usage:
#   jwt { version = "3.1.2"; }
#   jwt { }  # latest (3.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.2",
  git ? { },
}:
let
  versions = {
    "2.10.1" = import ./2.10.1 { inherit lib stdenv ruby; };
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jwt: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jwt: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
