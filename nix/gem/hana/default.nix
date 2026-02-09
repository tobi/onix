#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hana
#
# Available versions:
#   1.3.7
#
# Usage:
#   hana { version = "1.3.7"; }
#   hana { }  # latest (1.3.7)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.7",
  git ? { },
}:
let
  versions = {
    "1.3.7" = import ./1.3.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hana: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "hana: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
