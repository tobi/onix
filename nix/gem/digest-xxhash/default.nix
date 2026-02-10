#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# digest-xxhash
#
# Versions: 0.2.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.9",
  git ? { },
}:
let
  versions = {
    "0.2.9" = import ./0.2.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "digest-xxhash: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "digest-xxhash: unknown version '${version}'")
