#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# iso8601
#
# Versions: 0.13.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.13.0",
  git ? { },
}:
let
  versions = {
    "0.13.0" = import ./0.13.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "iso8601: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "iso8601: unknown version '${version}'")
