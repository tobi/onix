#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# artifactory
#
# Versions: 3.0.13, 3.0.15, 3.0.17
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.17",
  git ? { },
}:
let
  versions = {
    "3.0.13" = import ./3.0.13 { inherit lib stdenv ruby; };
    "3.0.15" = import ./3.0.15 { inherit lib stdenv ruby; };
    "3.0.17" = import ./3.0.17 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "artifactory: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "artifactory: unknown version '${version}'")
