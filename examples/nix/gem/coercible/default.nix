#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coercible
#
# Versions: 0.1.0, 0.2.0, 1.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.0",
  git ? { },
}:
let
  versions = {
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "coercible: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "coercible: unknown version '${version}'")
