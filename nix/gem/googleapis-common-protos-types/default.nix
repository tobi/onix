#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleapis-common-protos-types
#
# Available versions:
#   1.20.0
#
# Usage:
#   googleapis-common-protos-types { version = "1.20.0"; }
#   googleapis-common-protos-types { }  # latest (1.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.20.0",
  git ? { },
}:
let
  versions = {
    "1.20.0" = import ./1.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleapis-common-protos-types: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "googleapis-common-protos-types: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
