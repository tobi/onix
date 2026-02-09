#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# drb
#
# Available versions:
#   2.2.3
#
# Usage:
#   drb { version = "2.2.3"; }
#   drb { }  # latest (2.2.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.3",
  git ? { },
}:
let
  versions = {
    "2.2.3" = import ./2.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "drb: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "drb: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
