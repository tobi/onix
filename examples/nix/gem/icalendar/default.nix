#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# icalendar
#
# Versions: 2.11.2, 2.12.0, 2.12.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.12.1",
  git ? { },
}:
let
  versions = {
    "2.11.2" = import ./2.11.2 { inherit lib stdenv ruby; };
    "2.12.0" = import ./2.12.0 { inherit lib stdenv ruby; };
    "2.12.1" = import ./2.12.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "icalendar: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "icalendar: unknown version '${version}'")
