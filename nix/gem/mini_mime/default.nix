#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_mime
#
# Available versions:
#   1.1.5
#
# Usage:
#   mini_mime { version = "1.1.5"; }
#   mini_mime { }  # latest (1.1.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.5",
  git ? { },
}:
let
  versions = {
    "1.1.5" = import ./1.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_mime: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mini_mime: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
