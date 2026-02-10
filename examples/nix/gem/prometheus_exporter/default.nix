#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prometheus_exporter
#
# Versions: 2.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.1",
  git ? { },
}:
let
  versions = {
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "prometheus_exporter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "prometheus_exporter: unknown version '${version}'")
