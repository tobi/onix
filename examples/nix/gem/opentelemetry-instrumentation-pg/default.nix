#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-pg
#
# Versions: 0.35.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.35.0",
  git ? { },
}:
let
  versions = {
    "0.35.0" = import ./0.35.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-pg: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-pg: unknown version '${version}'")
