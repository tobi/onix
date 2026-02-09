#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-fonts
#
# Available versions:
#   0.0.19
#
# Usage:
#   discourse-fonts { version = "0.0.19"; }
#   discourse-fonts { }  # latest (0.0.19)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.19",
  git ? { },
}:
let
  versions = {
    "0.0.19" = import ./0.0.19 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse-fonts: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "discourse-fonts: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
