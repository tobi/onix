#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleapis-common-protos
#
# Versions: 1.6.0, 1.7.0, 1.8.0, 1.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.0",
  git ? { },
}:
let
  versions = {
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleapis-common-protos: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "googleapis-common-protos: unknown version '${version}'")
