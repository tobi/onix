#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httparty
#
# Available versions:
#   0.24.0
#
# Usage:
#   httparty { version = "0.24.0"; }
#   httparty { }  # latest (0.24.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.24.0",
  git ? { },
}:
let
  versions = {
    "0.24.0" = import ./0.24.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "httparty: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "httparty: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
