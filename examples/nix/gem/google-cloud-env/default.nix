#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-env
#
# Versions: 2.2.1, 2.2.2, 2.3.0, 2.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.1",
  git ? { },
}:
let
  versions = {
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-env: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-cloud-env: unknown version '${version}'")
