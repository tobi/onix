#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axe-core-rspec
#
# Versions: 4.11.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.11.1",
  git ? { },
}:
let
  versions = {
    "4.11.1" = import ./4.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "axe-core-rspec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "axe-core-rspec: unknown version '${version}'")
