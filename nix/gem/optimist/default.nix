#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# optimist
#
# Available versions:
#   3.2.1
#
# Usage:
#   optimist { version = "3.2.1"; }
#   optimist { }  # latest (3.2.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.1",
  git ? { },
}:
let
  versions = {
    "3.2.1" = import ./3.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "optimist: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "optimist: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
