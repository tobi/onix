#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-storage
#
# Available versions:
#   1.52.0
#
# Usage:
#   google-cloud-storage { version = "1.52.0"; }
#   google-cloud-storage { }  # latest (1.52.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.52.0",
  git ? { },
}:
let
  versions = {
    "1.52.0" = import ./1.52.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-storage: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-cloud-storage: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
