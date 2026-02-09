#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# barnes
#
# Available versions:
#   0.0.9
#
# Usage:
#   barnes { version = "0.0.9"; }
#   barnes { }  # latest (0.0.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.9",
  git ? { },
}:
let
  versions = {
    "0.0.9" = import ./0.0.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "barnes: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "barnes: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
