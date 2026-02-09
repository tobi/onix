#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# warden
#
# Available versions:
#   1.2.9
#
# Usage:
#   warden { version = "1.2.9"; }
#   warden { }  # latest (1.2.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.9",
  git ? { },
}:
let
  versions = {
    "1.2.9" = import ./1.2.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "warden: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "warden: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
