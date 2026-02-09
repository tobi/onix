#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# request_store
#
# Available versions:
#   1.5.1
#   1.7.0
#
# Usage:
#   request_store { version = "1.7.0"; }
#   request_store { }  # latest (1.7.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.0",
  git ? { },
}:
let
  versions = {
    "1.5.1" = import ./1.5.1 { inherit lib stdenv ruby; };
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "request_store: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "request_store: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
