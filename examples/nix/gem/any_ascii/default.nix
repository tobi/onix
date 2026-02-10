#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# any_ascii
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
    or (throw "any_ascii: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "any_ascii: unknown version '${version}'")
