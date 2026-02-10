#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_scheduler
#
# Versions: 0.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.0",
  git ? { },
}:
let
  versions = {
    "0.18.0" = import ./0.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_scheduler: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_scheduler: unknown version '${version}'")
