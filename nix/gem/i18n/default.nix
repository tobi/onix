#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n
#
# Available versions:
#   1.14.7
#   1.14.8
#
# Usage:
#   i18n { version = "1.14.8"; }
#   i18n { }  # latest (1.14.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.14.8",
  git ? { },
}:
let
  versions = {
    "1.14.7" = import ./1.14.7 { inherit lib stdenv ruby; };
    "1.14.8" = import ./1.14.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "i18n: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "i18n: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
