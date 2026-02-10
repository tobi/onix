#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry-stack_explorer
#
# Versions: 0.6.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.1",
  git ? { },
}:
let
  versions = {
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pry-stack_explorer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pry-stack_explorer: unknown version '${version}'")
