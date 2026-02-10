#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-accept
#
# Versions: 1.7.0, 2.1.1, 2.2.0, 2.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.1",
  git ? { },
}:
let
  versions = {
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-accept: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "http-accept: unknown version '${version}'")
