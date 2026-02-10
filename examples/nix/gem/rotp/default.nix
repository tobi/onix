#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rotp
#
# Versions: 6.2.1, 6.2.2, 6.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.3.0",
  git ? { },
}:
let
  versions = {
    "6.2.1" = import ./6.2.1 { inherit lib stdenv ruby; };
    "6.2.2" = import ./6.2.2 { inherit lib stdenv ruby; };
    "6.3.0" = import ./6.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rotp: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rotp: unknown version '${version}'")
