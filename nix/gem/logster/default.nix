#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logster
#
# Available versions:
#   2.20.1
#
# Usage:
#   logster { version = "2.20.1"; }
#   logster { }  # latest (2.20.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.20.1",
  git ? { },
}:
let
  versions = {
    "2.20.1" = import ./2.20.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "logster: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "logster: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
