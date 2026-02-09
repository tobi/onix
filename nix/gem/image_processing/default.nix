#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_processing
#
# Available versions:
#   1.12.2
#   1.14.0
#
# Usage:
#   image_processing { version = "1.14.0"; }
#   image_processing { }  # latest (1.14.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.14.0",
  git ? { },
}:
let
  versions = {
    "1.12.2" = import ./1.12.2 { inherit lib stdenv ruby; };
    "1.14.0" = import ./1.14.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "image_processing: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "image_processing: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
