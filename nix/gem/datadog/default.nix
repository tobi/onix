#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# datadog
#
# Available versions:
#   2.19.0
#
# Usage:
#   datadog { version = "2.19.0"; }
#   datadog { }  # latest (2.19.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.19.0",
  git ? { },
}:
let
  versions = {
    "2.19.0" = import ./2.19.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "datadog: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "datadog: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
