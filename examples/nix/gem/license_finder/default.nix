#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# license_finder
#
# Versions: 7.1.0, 7.2.0, 7.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.2.1",
  git ? { },
}:
let
  versions = {
    "7.1.0" = import ./7.1.0 { inherit lib stdenv ruby; };
    "7.2.0" = import ./7.2.0 { inherit lib stdenv ruby; };
    "7.2.1" = import ./7.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "license_finder: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "license_finder: unknown version '${version}'")
