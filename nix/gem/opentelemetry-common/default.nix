#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-common
#
# Available versions:
#   0.23.0
#
# Usage:
#   opentelemetry-common { version = "0.23.0"; }
#   opentelemetry-common { }  # latest (0.23.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.0",
  git ? { },
}:
let
  versions = {
    "0.23.0" = import ./0.23.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-common: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-common: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
