#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-exporter-otlp
#
# Available versions:
#   0.31.1
#
# Usage:
#   opentelemetry-exporter-otlp { version = "0.31.1"; }
#   opentelemetry-exporter-otlp { }  # latest (0.31.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.31.1",
  git ? { },
}:
let
  versions = {
    "0.31.1" = import ./0.31.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-exporter-otlp: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "opentelemetry-exporter-otlp: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
