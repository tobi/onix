#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-proxy
#
# Available versions:
#   0.7.7
#
# Usage:
#   rack-proxy { version = "0.7.7"; }
#   rack-proxy { }  # latest (0.7.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.7",
  git ? { },
}:
let
  versions = {
    "0.7.7" = import ./0.7.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-proxy: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rack-proxy: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
