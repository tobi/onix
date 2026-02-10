#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_histogram
#
# Versions: 0.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.1",
  git ? { },
}:
let
  versions = {
    "0.3.1" = import ./0.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_histogram: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_histogram: unknown version '${version}'")
