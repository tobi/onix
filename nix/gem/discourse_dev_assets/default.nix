#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_dev_assets
#
# Available versions:
#   0.0.6
#
# Usage:
#   discourse_dev_assets { version = "0.0.6"; }
#   discourse_dev_assets { }  # latest (0.0.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.6",
  git ? { },
}:
let
  versions = {
    "0.0.6" = import ./0.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse_dev_assets: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "discourse_dev_assets: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
