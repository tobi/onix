#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-performance
#
# Available versions:
#   1.25.0
#   1.26.1
#
# Usage:
#   rubocop-performance { version = "1.26.1"; }
#   rubocop-performance { }  # latest (1.26.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.26.1",
  git ? { },
}:
let
  versions = {
    "1.25.0" = import ./1.25.0 { inherit lib stdenv ruby; };
    "1.26.1" = import ./1.26.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-performance: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-performance: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
