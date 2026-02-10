#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic-sidekiq-metrics
#
# Versions: 1.6.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.2",
  git ? { },
}:
let
  versions = {
    "1.6.2" = import ./1.6.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "newrelic-sidekiq-metrics: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "newrelic-sidekiq-metrics: unknown version '${version}'")
