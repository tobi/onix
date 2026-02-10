#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simpleidn
#
# Versions: 0.2.1, 0.2.2, 0.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.3",
  git ? { },
}:
let
  versions = {
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
    "0.2.2" = import ./0.2.2 { inherit lib stdenv ruby; };
    "0.2.3" = import ./0.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simpleidn: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "simpleidn: unknown version '${version}'")
