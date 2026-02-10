#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_storage
#
# Versions: 0.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.1",
  git ? { },
}:
let
  versions = {
    "0.3.1" = import ./0.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-active_storage: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-active_storage: unknown version '${version}'")
