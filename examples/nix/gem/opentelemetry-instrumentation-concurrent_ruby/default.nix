#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-concurrent_ruby
#
# Versions: 0.24.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.24.0",
  git ? { },
}:
let
  versions = {
    "0.24.0" = import ./0.24.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-concurrent_ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-concurrent_ruby: unknown version '${version}'")
