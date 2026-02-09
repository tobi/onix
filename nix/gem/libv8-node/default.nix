#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libv8-node
#
# Available versions:
#   24.1.0.0
#
# Usage:
#   libv8-node { version = "24.1.0.0"; }
#   libv8-node { }  # latest (24.1.0.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "24.1.0.0",
  git ? { },
}:
let
  versions = {
    "24.1.0.0" = import ./24.1.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libv8-node: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "libv8-node: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
