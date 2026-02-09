#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-core
#
# Available versions:
#   0.15.1
#
# Usage:
#   google-apis-core { version = "0.15.1"; }
#   google-apis-core { }  # latest (0.15.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.1",
  git ? { },
}:
let
  versions = {
    "0.15.1" = import ./0.15.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-apis-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
