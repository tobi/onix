#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# local_time
#
# Versions: 3.0.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.3",
  git ? { },
}:
let
  versions = {
    "3.0.3" = import ./3.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "local_time: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "local_time: unknown version '${version}'")
