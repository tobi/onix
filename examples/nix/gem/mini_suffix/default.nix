#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_suffix
#
# Versions: 0.3.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.3",
  git ? { },
}:
let
  versions = {
    "0.3.3" = import ./0.3.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_suffix: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_suffix: unknown version '${version}'")
