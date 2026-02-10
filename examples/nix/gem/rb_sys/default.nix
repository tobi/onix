#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb_sys
#
# Versions: 0.9.119, 0.9.124
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.124",
  git ? { },
}:
let
  versions = {
    "0.9.119" = import ./0.9.119 { inherit lib stdenv ruby; };
    "0.9.124" = import ./0.9.124 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb_sys: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rb_sys: unknown version '${version}'")
