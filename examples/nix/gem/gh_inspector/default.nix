#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gh_inspector
#
# Versions: 1.1.1, 1.1.2, 1.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.3",
  git ? { },
}:
let
  versions = {
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.1.3" = import ./1.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gh_inspector: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gh_inspector: unknown version '${version}'")
