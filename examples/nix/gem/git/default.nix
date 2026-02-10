#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# git
#
# Versions: 4.1.2, 4.2.0, 4.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.3.0",
  git ? { },
}:
let
  versions = {
    "4.1.2" = import ./4.1.2 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
    "4.3.0" = import ./4.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "git: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "git: unknown version '${version}'")
