#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# byebug
#
# Available versions:
#   11.1.3
#
# Usage:
#   byebug { version = "11.1.3"; }
#   byebug { }  # latest (11.1.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "11.1.3",
  git ? { },
}:
let
  versions = {
    "11.1.3" = import ./11.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "byebug: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "byebug: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
