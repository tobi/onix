#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleapis-common-protos
#
# Available versions:
#   1.6.0
#
# Usage:
#   googleapis-common-protos { version = "1.6.0"; }
#   googleapis-common-protos { }  # latest (1.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.0",
  git ? { },
}:
let
  versions = {
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleapis-common-protos: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "googleapis-common-protos: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
