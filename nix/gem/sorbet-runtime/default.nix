#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sorbet-runtime
#
# Available versions:
#   0.5.11934
#
# Usage:
#   sorbet-runtime { version = "0.5.11934"; }
#   sorbet-runtime { }  # latest (0.5.11934)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.11934",
  git ? { },
}:
let
  versions = {
    "0.5.11934" = import ./0.5.11934 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sorbet-runtime: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sorbet-runtime: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
