#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# friendly_id
#
# Versions: 5.5.0, 5.5.1, 5.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.6.0",
  git ? { },
}:
let
  versions = {
    "5.5.0" = import ./5.5.0 { inherit lib stdenv ruby; };
    "5.5.1" = import ./5.5.1 { inherit lib stdenv ruby; };
    "5.6.0" = import ./5.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "friendly_id: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "friendly_id: unknown version '${version}'")
