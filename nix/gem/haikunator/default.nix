#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haikunator
#
# Available versions:
#   1.1.1
#
# Usage:
#   haikunator { version = "1.1.1"; }
#   haikunator { }  # latest (1.1.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.1",
  git ? { },
}:
let
  versions = {
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "haikunator: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "haikunator: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
