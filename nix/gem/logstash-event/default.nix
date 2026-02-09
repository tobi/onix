#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logstash-event
#
# Available versions:
#   1.2.02
#
# Usage:
#   logstash-event { version = "1.2.02"; }
#   logstash-event { }  # latest (1.2.02)
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
    or (throw "logstash-event: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "logstash-event: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
