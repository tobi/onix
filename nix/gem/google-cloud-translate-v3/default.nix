#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-translate-v3
#
# Versions: 0.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.0",
  git ? { },
}:
let
  versions = {
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-cloud-translate-v3: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-cloud-translate-v3: unknown version '${version}'")
