#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-protobuf
#
# Available versions:
#   3.25.7
#   4.33.2
#
# Usage:
#   google-protobuf { version = "4.33.2"; }
#   google-protobuf { }  # latest (4.33.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.33.2",
  git ? { },
}:
let
  versions = {
    "3.25.7" = import ./3.25.7 { inherit lib stdenv ruby; };
    "4.33.2" = import ./4.33.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-protobuf: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "google-protobuf: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
