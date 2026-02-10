#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# power_assert
#
# Versions: 2.0.5, 3.0.0, 3.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.1",
  git ? { },
}:
let
  versions = {
    "2.0.5" = import ./2.0.5 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "power_assert: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "power_assert: unknown version '${version}'")
