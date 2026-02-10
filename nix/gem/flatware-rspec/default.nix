#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flatware-rspec
#
# Versions: 2.3.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.4",
  git ? { },
}:
let
  versions = {
    "2.3.4" = import ./2.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flatware-rspec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "flatware-rspec: unknown version '${version}'")
