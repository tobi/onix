#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# execjs
#
# Versions: 2.8.1, 2.9.0, 2.9.1, 2.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.10.0",
  git ? { },
}:
let
  versions = {
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "2.9.0" = import ./2.9.0 { inherit lib stdenv ruby; };
    "2.9.1" = import ./2.9.1 { inherit lib stdenv ruby; };
    "2.10.0" = import ./2.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "execjs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "execjs: unknown version '${version}'")
