#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gli
#
# Available versions:
#   2.22.2
#
# Usage:
#   gli { version = "2.22.2"; }
#   gli { }  # latest (2.22.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.22.2",
  git ? { },
}:
let
  versions = {
    "2.22.2" = import ./2.22.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gli: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "gli: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
