#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-event
#
# Versions: 1.2.02
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.02",
  git ? { },
}:
let
  versions = {
    "1.2.02" = import ./1.2.02 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logstash-event: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "logstash-event: unknown version '${version}'")
