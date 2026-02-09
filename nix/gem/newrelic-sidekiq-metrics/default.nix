#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic-sidekiq-metrics
#
# Available versions:
#   1.6.2
#
# Usage:
#   newrelic-sidekiq-metrics { version = "1.6.2"; }
#   newrelic-sidekiq-metrics { }  # latest (1.6.2)
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
    or (throw "newrelic-sidekiq-metrics: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "newrelic-sidekiq-metrics: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
