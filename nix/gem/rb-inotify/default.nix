#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-inotify
#
# Available versions:
#   0.10.1
#   0.11.1
#
# Usage:
#   rb-inotify { version = "0.11.1"; }
#   rb-inotify { }  # latest (0.11.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.1",
  git ? { },
}:
let
  versions = {
    "0.10.1" = import ./0.10.1 { inherit lib stdenv ruby; };
    "0.11.1" = import ./0.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb-inotify: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rb-inotify: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
