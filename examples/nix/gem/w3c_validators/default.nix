#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# w3c_validators
#
# Versions: 1.3.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.7",
  git ? { },
}:
let
  versions = {
    "1.3.7" = import ./1.3.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "w3c_validators: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "w3c_validators: unknown version '${version}'")
