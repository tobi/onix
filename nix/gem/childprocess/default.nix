#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# childprocess
#
# Available versions:
#   5.1.0
#
# Usage:
#   childprocess { version = "5.1.0"; }
#   childprocess { }  # latest (5.1.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.1.0",
  git ? { },
}:
let
  versions = {
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "childprocess: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "childprocess: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
