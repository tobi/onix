#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# commonmarker
#
# Available versions:
#   0.23.10
#
# Usage:
#   commonmarker { version = "0.23.10"; }
#   commonmarker { }  # latest (0.23.10)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.10",
  git ? { },
}:
let
  versions = {
    "0.23.10" = import ./0.23.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "commonmarker: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "commonmarker: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
