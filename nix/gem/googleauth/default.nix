#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleauth
#
# Versions: 1.11.2, 1.12.2, 1.15.1, 1.16.0, 1.16.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.16.1",
  git ? { },
}:
let
  versions = {
    "1.11.2" = import ./1.11.2 { inherit lib stdenv ruby; };
    "1.12.2" = import ./1.12.2 { inherit lib stdenv ruby; };
    "1.15.1" = import ./1.15.1 { inherit lib stdenv ruby; };
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.16.1" = import ./1.16.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleauth: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "googleauth: unknown version '${version}'")
