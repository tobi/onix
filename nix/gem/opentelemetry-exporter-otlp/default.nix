#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-exporter-otlp
#
# Versions: 0.31.1
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
    or (throw "opentelemetry-exporter-otlp: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-exporter-otlp: unknown version '${version}'")
