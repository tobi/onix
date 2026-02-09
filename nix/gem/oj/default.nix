#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oj
#
# Available versions:
#   3.16.10
#   3.16.12
#
# Usage:
#   oj { version = "3.16.12"; }
#   oj { }  # latest (3.16.12)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.16.12",
  git ? { },
}:
let
  versions = {
    "3.16.10" = import ./3.16.10 { inherit lib stdenv ruby; };
    "3.16.12" = import ./3.16.12 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "oj: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "oj: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
