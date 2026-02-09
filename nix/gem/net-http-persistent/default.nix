#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http-persistent
#
# Available versions:
#   4.0.2
#   4.0.8
#
# Usage:
#   net-http-persistent { version = "4.0.8"; }
#   net-http-persistent { }  # latest (4.0.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.8",
  git ? { },
}:
let
  versions = {
    "4.0.2" = import ./4.0.2 { inherit lib stdenv ruby; };
    "4.0.8" = import ./4.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-http-persistent: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-http-persistent: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
