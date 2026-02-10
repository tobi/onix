#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# argon2
#
# Versions: 2.3.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.2",
  git ? { },
}:
let
  versions = {
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "argon2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "argon2: unknown version '${version}'")
