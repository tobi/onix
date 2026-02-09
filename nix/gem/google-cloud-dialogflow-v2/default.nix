#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-dialogflow-v2
#
# Available versions:
#   0.31.0
#
# Usage:
#   google-cloud-dialogflow-v2 { version = "0.31.0"; }
#   google-cloud-dialogflow-v2 { }  # latest (0.31.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.31.0",
  git ? { },
}:
let
  versions = {
    "0.31.0" = import ./0.31.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-dialogflow-v2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-cloud-dialogflow-v2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
