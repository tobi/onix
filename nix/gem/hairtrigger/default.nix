#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hairtrigger
#
# Versions: 1.0.0, 1.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.1",
  git ? { },
}:
let
  versions = {
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hairtrigger: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hairtrigger: unknown version '${version}'")
