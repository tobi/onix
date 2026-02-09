#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov
#
# Available versions:
#   0.22.0
#
# Usage:
#   simplecov { version = "0.22.0"; }
#   simplecov { }  # latest (0.22.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.22.0",
  git ? { },
}:
let
  versions = {
    "0.22.0" = import ./0.22.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simplecov: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "simplecov: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
