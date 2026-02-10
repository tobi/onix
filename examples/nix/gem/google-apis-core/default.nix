#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-core
#
# Versions: 0.15.1, 1.0.0, 1.0.1, 1.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.2",
  git ? { },
}:
let
  versions = {
    "0.15.1" = import ./0.15.1 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "google-apis-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "google-apis-core: unknown version '${version}'")
