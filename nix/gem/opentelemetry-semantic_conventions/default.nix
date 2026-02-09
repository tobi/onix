#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-semantic_conventions
#
# Available versions:
#   1.36.0
#
# Usage:
#   opentelemetry-semantic_conventions { version = "1.36.0"; }
#   opentelemetry-semantic_conventions { }  # latest (1.36.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.36.0",
  git ? { },
}:
let
  versions = {
    "1.36.0" = import ./1.36.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-semantic_conventions: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-semantic_conventions: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
