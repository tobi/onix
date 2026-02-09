#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-core
#
# Available versions:
#   1.7.1
#
# Usage:
#   google-cloud-core { version = "1.7.1"; }
#   google-cloud-core { }  # latest (1.7.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.1",
  git ? { },
}:
let
  versions = {
    "1.7.1" = import ./1.7.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-cloud-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
