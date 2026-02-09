#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic_rpm
#
# Available versions:
#   9.6.0
#
# Usage:
#   newrelic_rpm { version = "9.6.0"; }
#   newrelic_rpm { }  # latest (9.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.6.0",
  git ? { },
}:
let
  versions = {
    "9.6.0" = import ./9.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "newrelic_rpm: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "newrelic_rpm: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
