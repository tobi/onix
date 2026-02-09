#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rswag-specs
#
# Available versions:
#   2.17.0
#
# Usage:
#   rswag-specs { version = "2.17.0"; }
#   rswag-specs { }  # latest (2.17.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.17.0",
  git ? { },
}:
let
  versions = {
    "2.17.0" = import ./2.17.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rswag-specs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rswag-specs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
