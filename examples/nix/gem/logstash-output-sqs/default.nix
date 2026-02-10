#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-output-sqs
#
# Versions: 5.1.1, 5.1.2, 6.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.0",
  git ? { },
}:
let
  versions = {
    "5.1.1" = import ./5.1.1 { inherit lib stdenv ruby; };
    "5.1.2" = import ./5.1.2 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logstash-output-sqs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "logstash-output-sqs: unknown version '${version}'")
