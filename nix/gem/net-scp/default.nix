#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-scp
#
# Available versions:
#   4.1.0
#
# Usage:
#   net-scp { version = "4.1.0"; }
#   net-scp { }  # latest (4.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.0",
  git ? { },
}:
let
  versions = {
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-scp: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-scp: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
