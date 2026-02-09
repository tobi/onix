#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# os
#
# Available versions:
#   1.1.4
#
# Usage:
#   os { version = "1.1.4"; }
#   os { }  # latest (1.1.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.4",
  git ? { },
}:
let
  versions = {
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "os: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "os: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
