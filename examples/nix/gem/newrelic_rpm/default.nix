#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic_rpm
#
# Versions: 9.6.0, 9.24.0, 10.0.0, 10.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "10.1.0",
  git ? { },
}:
let
  versions = {
    "9.6.0" = import ./9.6.0 { inherit lib stdenv ruby; };
    "9.24.0" = import ./9.24.0 { inherit lib stdenv ruby; };
    "10.0.0" = import ./10.0.0 { inherit lib stdenv ruby; };
    "10.1.0" = import ./10.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "newrelic_rpm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "newrelic_rpm: unknown version '${version}'")
