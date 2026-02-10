#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# honeybadger
#
# Versions: 4.12.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.12.2",
  git ? { },
}:
let
  versions = {
    "4.12.2" = import ./4.12.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "honeybadger: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "honeybadger: unknown version '${version}'")
