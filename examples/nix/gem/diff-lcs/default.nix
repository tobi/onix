#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# diff-lcs
#
# Versions: 1.5.1, 1.6.1, 1.6.2, 2.0.0.beta.2, 2.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0",
  git ? { },
}:
let
  versions = {
    "1.5.1" = import ./1.5.1 { inherit lib stdenv ruby; };
    "1.6.1" = import ./1.6.1 { inherit lib stdenv ruby; };
    "1.6.2" = import ./1.6.2 { inherit lib stdenv ruby; };
    "2.0.0.beta.2" = import ./2.0.0.beta.2 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "diff-lcs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "diff-lcs: unknown version '${version}'")
