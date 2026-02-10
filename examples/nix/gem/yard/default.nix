#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yard
#
# Versions: 0.9.36, 0.9.37, 0.9.38
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.38",
  git ? { },
}:
let
  versions = {
    "0.9.36" = import ./0.9.36 { inherit lib stdenv ruby; };
    "0.9.37" = import ./0.9.37 { inherit lib stdenv ruby; };
    "0.9.38" = import ./0.9.38 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "yard: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "yard: unknown version '${version}'")
