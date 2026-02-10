#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_record
#
# Versions: 0.11.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.1",
  git ? { },
}:
let
  versions = {
    "0.11.1" = import ./0.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-instrumentation-active_record: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-instrumentation-active_record: unknown version '${version}'")
