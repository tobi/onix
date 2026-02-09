#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erubi
#
# Available versions:
#   1.13.0
#   1.13.1
#
# Usage:
#   erubi { version = "1.13.1"; }
#   erubi { }  # latest (1.13.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.13.1",
  git ? { },
}:
let
  versions = {
    "1.13.0" = import ./1.13.0 { inherit lib stdenv ruby; };
    "1.13.1" = import ./1.13.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erubi: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "erubi: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
