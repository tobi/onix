#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-net_http
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
    or (throw "opentelemetry-instrumentation-net_http: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-net_http: unknown version '${version}'")
