#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# racc
#
# Versions: 1.7.3, 1.8.0, 1.8.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.1",
  git ? { },
}:
let
  versions = {
    "1.7.3" = import ./1.7.3 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.8.1" = import ./1.8.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "racc: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "racc: unknown version '${version}'")
