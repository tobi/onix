#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbtrace
#
# Available versions:
#   0.5.3
#
# Usage:
#   rbtrace { version = "0.5.3"; }
#   rbtrace { }  # latest (0.5.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.3",
  git ? { },
}:
let
  versions = {
    "0.5.3" = import ./0.5.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rbtrace: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rbtrace: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
