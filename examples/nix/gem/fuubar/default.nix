#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuubar
#
# Versions: 2.4.1, 2.5.0, 2.5.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.5.1",
  git ? { },
}:
let
  versions = {
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
    "2.5.0" = import ./2.5.0 { inherit lib stdenv ruby; };
    "2.5.1" = import ./2.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fuubar: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fuubar: unknown version '${version}'")
