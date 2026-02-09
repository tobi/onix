#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-retry
#
# Available versions:
#   2.2.1
#   2.3.2
#
# Usage:
#   faraday-retry { version = "2.3.2"; }
#   faraday-retry { }  # latest (2.3.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.2",
  git ? { },
}:
let
  versions = {
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-retry: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-retry: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
