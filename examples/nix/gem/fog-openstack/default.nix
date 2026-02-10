#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-openstack
#
# Versions: 1.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.5",
  git ? { },
}:
let
  versions = {
    "1.1.5" = import ./1.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-openstack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fog-openstack: unknown version '${version}'")
