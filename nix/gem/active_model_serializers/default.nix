#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_model_serializers
#
# Available versions:
#   0.8.4
#
# Usage:
#   active_model_serializers { version = "0.8.4"; }
#   active_model_serializers { }  # latest (0.8.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.4",
  git ? { },
}:
let
  versions = {
    "0.8.4" = import ./0.8.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "active_model_serializers: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "active_model_serializers: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
