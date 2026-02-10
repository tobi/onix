#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleapis-common-protos-types
#
# Versions: 1.20.0, 1.21.0, 1.22.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.22.0",
  git ? { },
}:
let
  versions = {
    "1.20.0" = import ./1.20.0 { inherit lib stdenv ruby; };
    "1.21.0" = import ./1.21.0 { inherit lib stdenv ruby; };
    "1.22.0" = import ./1.22.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleapis-common-protos-types: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "googleapis-common-protos-types: unknown version '${version}'")
