#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-pop
#
# Versions: 0.1.0, 0.1.1, 0.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.2",
  git ? { },
}:
let
  versions = {
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-pop: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-pop: unknown version '${version}'")
