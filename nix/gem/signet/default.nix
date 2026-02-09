#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# signet
#
# Available versions:
#   0.17.0
#
# Usage:
#   signet { version = "0.17.0"; }
#   signet { }  # latest (0.17.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.17.0",
  git ? { },
}:
let
  versions = {
    "0.17.0" = import ./0.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "signet: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "signet: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
