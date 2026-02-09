#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parallel_tests
#
# Available versions:
#   5.5.0
#
# Usage:
#   parallel_tests { version = "5.5.0"; }
#   parallel_tests { }  # latest (5.5.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.5.0",
  git ? { },
}:
let
  versions = {
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "parallel_tests: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "parallel_tests: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
