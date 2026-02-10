#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# macaddr
#
# Versions: 1.7.0, 1.7.1, 1.7.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.2",
  git ? { },
}:
let
  versions = {
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.7.1" = import ./1.7.1 { inherit lib stdenv ruby; };
    "1.7.2" = import ./1.7.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "macaddr: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "macaddr: unknown version '${version}'")
