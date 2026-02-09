#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# searchkick
#
# Available versions:
#   5.5.2
#
# Usage:
#   searchkick { version = "5.5.2"; }
#   searchkick { }  # latest (5.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.5.2",
  git ? { },
}:
let
  versions = {
    "5.5.2" = import ./5.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "searchkick: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "searchkick: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
