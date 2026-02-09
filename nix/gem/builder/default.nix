#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# builder
#
# Available versions:
#   3.3.0
#
# Usage:
#   builder { version = "3.3.0"; }
#   builder { }  # latest (3.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.0",
  git ? { },
}:
let
  versions = {
    "3.3.0" = import ./3.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "builder: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "builder: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
