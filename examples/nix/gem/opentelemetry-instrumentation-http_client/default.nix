#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-http_client
#
# Versions: 0.27.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.27.0",
  git ? { },
}:
let
  versions = {
    "0.27.0" = import ./0.27.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-http_client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-http_client: unknown version '${version}'")
