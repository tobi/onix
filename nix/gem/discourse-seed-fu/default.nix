#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-seed-fu
#
# Available versions:
#   2.3.12
#
# Usage:
#   discourse-seed-fu { version = "2.3.12"; }
#   discourse-seed-fu { }  # latest (2.3.12)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.12",
  git ? { },
}:
let
  versions = {
    "2.3.12" = import ./2.3.12 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse-seed-fu: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "discourse-seed-fu: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
