#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# open3
#
# Versions: 0.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.1",
  git ? { },
}:
let
  versions = {
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "open3: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "open3: unknown version '${version}'")
