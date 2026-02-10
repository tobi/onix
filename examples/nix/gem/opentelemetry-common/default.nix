#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-common
#
# Versions: 0.21.0, 0.22.0, 0.23.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.0",
  git ? { },
}:
let
  versions = {
    "0.21.0" = import ./0.21.0 { inherit lib stdenv ruby; };
    "0.22.0" = import ./0.22.0 { inherit lib stdenv ruby; };
    "0.23.0" = import ./0.23.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-common: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-common: unknown version '${version}'")
