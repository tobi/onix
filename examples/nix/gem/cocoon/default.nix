#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoon
#
# Versions: 1.2.15
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.15",
  git ? { },
}:
let
  versions = {
    "1.2.15" = import ./1.2.15 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoon: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cocoon: unknown version '${version}'")
