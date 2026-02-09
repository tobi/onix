#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard
#
# Available versions:
#   0.9.38
#
# Usage:
#   yard { version = "0.9.38"; }
#   yard { }  # latest (0.9.38)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.38",
  git ? { },
}:
let
  versions = {
    "0.9.38" = import ./0.9.38 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yard: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "yard: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
