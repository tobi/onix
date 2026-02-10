#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-rails
#
# Versions: 0.39.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.39.1",
  git ? { },
}:
let
  versions = {
    "0.39.1" = import ./0.39.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-rails: unknown version '${version}'")
