#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-github
#
# Versions: 1.4.0, 2.0.0, 2.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.1",
  git ? { },
}:
let
  versions = {
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-github: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omniauth-github: unknown version '${version}'")
