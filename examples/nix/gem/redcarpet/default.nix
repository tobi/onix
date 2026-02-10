#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redcarpet
#
# Versions: 3.5.1, 3.6.0, 3.6.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.1",
  git ? { },
}:
let
  versions = {
    "3.5.1" = import ./3.5.1 { inherit lib stdenv ruby; };
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
    "3.6.1" = import ./3.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "redcarpet: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "redcarpet: unknown version '${version}'")
