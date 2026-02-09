#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_refs
#
# Available versions:
#   0.1.8
#
# Usage:
#   json_refs { version = "0.1.8"; }
#   json_refs { }  # latest (0.1.8)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.8",
  git ? { },
}:
let
  versions = {
    "0.1.8" = import ./0.1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json_refs: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "json_refs: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
