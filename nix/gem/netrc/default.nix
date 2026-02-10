#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# netrc
#
# Versions: 0.10.2, 0.10.3, 0.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.0",
  git ? { },
}:
let
  versions = {
    "0.10.2" = import ./0.10.2 { inherit lib stdenv ruby; };
    "0.10.3" = import ./0.10.3 { inherit lib stdenv ruby; };
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "netrc: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "netrc: unknown version '${version}'")
