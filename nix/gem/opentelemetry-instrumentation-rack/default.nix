#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-rack
#
# Versions: 0.29.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.29.0",
  git ? { },
}:
let
  versions = {
    "0.29.0" = import ./0.29.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-rack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-rack: unknown version '${version}'")
