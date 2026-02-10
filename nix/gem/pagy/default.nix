#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pagy
#
# Versions: 43.2.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "43.2.9",
  git ? { },
}:
let
  versions = {
    "43.2.9" = import ./43.2.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pagy: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pagy: unknown version '${version}'")
