#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kamal
#
# Available versions:
#   2.10.1
#
# Usage:
#   kamal { version = "2.10.1"; }
#   kamal { }  # latest (2.10.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.10.1",
  git ? { },
}:
let
  versions = {
    "2.10.1" = import ./2.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kamal: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "kamal: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
