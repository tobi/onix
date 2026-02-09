#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activestorage
#
# Available versions:
#   7.1.5.2
#
# Usage:
#   activestorage { version = "7.1.5.2"; }
#   activestorage { }  # latest (7.1.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.5.2",
  git ? { },
}:
let
  versions = {
    "7.1.5.2" = import ./7.1.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "activestorage: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "activestorage: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
