#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vite_rails
#
# Available versions:
#   3.0.17
#
# Usage:
#   vite_rails { version = "3.0.17"; }
#   vite_rails { }  # latest (3.0.17)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.17",
  git ? { },
}:
let
  versions = {
    "3.0.17" = import ./3.0.17 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vite_rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "vite_rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
