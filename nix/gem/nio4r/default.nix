#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nio4r
#
# Available versions:
#   2.7.3
#   2.7.5
#
# Usage:
#   nio4r { version = "2.7.5"; }
#   nio4r { }  # latest (2.7.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.7.5",
  git ? { },
}:
let
  versions = {
    "2.7.3" = import ./2.7.3 { inherit lib stdenv ruby; };
    "2.7.5" = import ./2.7.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nio4r: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "nio4r: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
