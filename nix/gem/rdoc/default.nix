#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdoc
#
# Available versions:
#   6.17.0
#   7.0.3
#
# Usage:
#   rdoc { version = "7.0.3"; }
#   rdoc { }  # latest (7.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.3",
  git ? { },
}:
let
  versions = {
    "6.17.0" = import ./6.17.0 { inherit lib stdenv ruby; };
    "7.0.3" = import ./7.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rdoc: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rdoc: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
