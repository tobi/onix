#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-inotify
#
# Versions: 0.10.1, 0.11.0, 0.11.1
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
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
    "0.11.1" = import ./0.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb-inotify: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rb-inotify: unknown version '${version}'")
