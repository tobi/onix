#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_job
#
# Versions: 0.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.1",
  git ? { },
}:
let
  versions = {
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-active_job: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-active_job: unknown version '${version}'")
