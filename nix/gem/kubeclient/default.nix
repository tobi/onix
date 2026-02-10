#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kubeclient
#
# Versions: 4.11.0, 4.12.0, 4.13.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.13.0",
  git ? { },
}:
let
  versions = {
    "4.11.0" = import ./4.11.0 { inherit lib stdenv ruby; };
    "4.12.0" = import ./4.12.0 { inherit lib stdenv ruby; };
    "4.13.0" = import ./4.13.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kubeclient: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "kubeclient: unknown version '${version}'")
