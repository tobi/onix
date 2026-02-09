#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httpclient
#
# Available versions:
#   2.8.3
#
# Usage:
#   httpclient { version = "2.8.3"; }
#   httpclient { }  # latest (2.8.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.8.3",
  git ? { },
}:
let
  versions = {
    "2.8.3" = import ./2.8.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "httpclient: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "httpclient: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
