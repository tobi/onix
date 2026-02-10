#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_dev_assets
#
# Versions: 0.0.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.6",
  git ? { },
}:
let
  versions = {
    "0.0.6" = import ./0.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse_dev_assets: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discourse_dev_assets: unknown version '${version}'")
