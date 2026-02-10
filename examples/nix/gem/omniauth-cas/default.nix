#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-cas
#
# Versions: 3.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.2",
  git ? { },
}:
let
  versions = {
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-cas: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omniauth-cas: unknown version '${version}'")
