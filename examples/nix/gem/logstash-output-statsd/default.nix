#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-output-statsd
#
# Versions: 3.1.4, 3.1.5, 3.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.0",
  git ? { },
}:
let
  versions = {
    "3.1.4" = import ./3.1.4 { inherit lib stdenv ruby; };
    "3.1.5" = import ./3.1.5 { inherit lib stdenv ruby; };
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logstash-output-statsd: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "logstash-output-statsd: unknown version '${version}'")
