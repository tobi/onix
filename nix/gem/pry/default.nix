#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry
#
# Available versions:
#   0.14.2
#   0.15.2
#
# Usage:
#   pry { version = "0.15.2"; }
#   pry { }  # latest (0.15.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.2",
  git ? { },
}:
let
  versions = {
    "0.14.2" = import ./0.14.2 { inherit lib stdenv ruby; };
    "0.15.2" = import ./0.15.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pry: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pry: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
