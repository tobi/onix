#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-downloader
#
# Versions: 1.6.3, 2.0, 2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1",
  git ? { },
}:
let
  versions = {
    "1.6.3" = import ./1.6.3 { inherit lib stdenv ruby; };
    "2.0" = import ./2.0 { inherit lib stdenv ruby; };
    "2.1" = import ./2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cocoapods-downloader: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cocoapods-downloader: unknown version '${version}'")
