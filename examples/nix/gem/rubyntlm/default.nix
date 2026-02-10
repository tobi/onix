#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyntlm
#
# Versions: 0.6.3, 0.6.4, 0.6.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.5",
  git ? { },
}:
let
  versions = {
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby; };
    "0.6.4" = import ./0.6.4 { inherit lib stdenv ruby; };
    "0.6.5" = import ./0.6.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubyntlm: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubyntlm: unknown version '${version}'")
