#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-androidpublisher_v3
#
# Versions: 0.94.0, 0.95.0, 0.96.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.96.0",
  git ? { },
}:
let
  versions = {
    "0.94.0" = import ./0.94.0 { inherit lib stdenv ruby; };
    "0.95.0" = import ./0.95.0 { inherit lib stdenv ruby; };
    "0.96.0" = import ./0.96.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-androidpublisher_v3: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-apis-androidpublisher_v3: unknown version '${version}'")
