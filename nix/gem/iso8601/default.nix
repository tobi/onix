#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# iso8601
#
# Available versions:
#   0.13.0
#
# Usage:
#   iso8601 { version = "0.13.0"; }
#   iso8601 { }  # latest (0.13.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.13.0",
  git ? { },
}:
let
  versions = {
    "0.13.0" = import ./0.13.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "iso8601: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "iso8601: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
