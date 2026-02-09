#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zip_kit
#
# Available versions:
#   6.3.4
#
# Usage:
#   zip_kit { version = "6.3.4"; }
#   zip_kit { }  # latest (6.3.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.3.4",
  git ? { },
}:
let
  versions = {
    "6.3.4" = import ./6.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "zip_kit: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "zip_kit: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
