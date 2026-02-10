#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-api-client
#
# Versions: 0.51.0, 0.52.0, 0.53.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.53.0",
  git ? { },
}:
let
  versions = {
    "0.51.0" = import ./0.51.0 { inherit lib stdenv ruby; };
    "0.52.0" = import ./0.52.0 { inherit lib stdenv ruby; };
    "0.53.0" = import ./0.53.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-api-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-api-client: unknown version '${version}'")
