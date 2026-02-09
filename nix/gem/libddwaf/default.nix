#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libddwaf
#
# Available versions:
#   1.24.1.0.3
#
# Usage:
#   libddwaf { version = "1.24.1.0.3"; }
#   libddwaf { }  # latest (1.24.1.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.24.1.0.3",
  git ? { },
}:
let
  versions = {
    "1.24.1.0.3" = import ./1.24.1.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libddwaf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "libddwaf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
