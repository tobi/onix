#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-faraday
#
# Versions: 0.31.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.31.0",
  git ? { },
}:
let
  versions = {
    "0.31.0" = import ./0.31.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-faraday: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-faraday: unknown version '${version}'")
