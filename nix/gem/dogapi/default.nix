#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dogapi
#
# Versions: 1.43.0, 1.44.0, 1.45.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.45.0",
  git ? { },
}:
let
  versions = {
    "1.43.0" = import ./1.43.0 { inherit lib stdenv ruby; };
    "1.44.0" = import ./1.44.0 { inherit lib stdenv ruby; };
    "1.45.0" = import ./1.45.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dogapi: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dogapi: unknown version '${version}'")
