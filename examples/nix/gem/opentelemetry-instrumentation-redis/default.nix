#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-redis
#
# Versions: 0.28.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.28.0",
  git ? { },
}:
let
  versions = {
    "0.28.0" = import ./0.28.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-redis: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-redis: unknown version '${version}'")
