#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kamal
#
# Versions: 2.4.0, 2.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.10.1",
  git ? { },
}:
let
  versions = {
    "2.4.0" = import ./2.4.0 { inherit lib stdenv ruby; };
    "2.10.1" = import ./2.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "kamal: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "kamal: unknown version '${version}'")
