#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ipaddress
#
# Versions: 0.8.0, 0.8.2, 0.8.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.3",
  git ? { },
}:
let
  versions = {
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.8.2" = import ./0.8.2 { inherit lib stdenv ruby; };
    "0.8.3" = import ./0.8.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ipaddress: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ipaddress: unknown version '${version}'")
