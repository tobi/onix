#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_optim
#
# Available versions:
#   0.31.4
#
# Usage:
#   image_optim { version = "0.31.4"; }
#   image_optim { }  # latest (0.31.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.31.4",
  git ? { },
}:
let
  versions = {
    "0.31.4" = import ./0.31.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "image_optim: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "image_optim: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
