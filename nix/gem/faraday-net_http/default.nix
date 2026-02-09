#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-net_http
#
# Available versions:
#   3.4.0
#   3.4.2
#
# Usage:
#   faraday-net_http { version = "3.4.2"; }
#   faraday-net_http { }  # latest (3.4.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.2",
  git ? { },
}:
let
  versions = {
    "3.4.0" = import ./3.4.0 { inherit lib stdenv ruby; };
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-net_http: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "faraday-net_http: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
