#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# listen
#
# Versions: 3.8.0, 3.9.0, 3.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.10.0",
  git ? { },
}:
let
  versions = {
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
    "3.10.0" = import ./3.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "listen: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "listen: unknown version '${version}'")
