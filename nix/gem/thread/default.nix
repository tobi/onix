#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thread
#
# Versions: 0.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.2",
  git ? { },
}:
let
  versions = {
    "0.2.2" = import ./0.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thread: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "thread: unknown version '${version}'")
