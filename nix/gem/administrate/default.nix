#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# administrate
#
# Available versions:
#   0.20.1
#
# Usage:
#   administrate { version = "0.20.1"; }
#   administrate { }  # latest (0.20.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.1",
  git ? { },
}:
let
  versions = {
    "0.20.1" = import ./0.20.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "administrate: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "administrate: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
