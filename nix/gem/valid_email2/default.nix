#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# valid_email2
#
# Available versions:
#   5.2.6
#
# Usage:
#   valid_email2 { version = "5.2.6"; }
#   valid_email2 { }  # latest (5.2.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.6",
  git ? { },
}:
let
  versions = {
    "5.2.6" = import ./5.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "valid_email2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "valid_email2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
