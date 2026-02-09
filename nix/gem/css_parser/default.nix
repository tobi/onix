#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# css_parser
#
# Available versions:
#   1.21.1
#
# Usage:
#   css_parser { version = "1.21.1"; }
#   css_parser { }  # latest (1.21.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.21.1",
  git ? { },
}:
let
  versions = {
    "1.21.1" = import ./1.21.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "css_parser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "css_parser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
