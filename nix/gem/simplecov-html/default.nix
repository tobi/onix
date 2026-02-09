#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov-html
#
# Available versions:
#   0.13.2
#
# Usage:
#   simplecov-html { version = "0.13.2"; }
#   simplecov-html { }  # latest (0.13.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.13.2",
  git ? { },
}:
let
  versions = {
    "0.13.2" = import ./0.13.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simplecov-html: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "simplecov-html: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
