#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debug
#
# Versions: 1.8.0, 1.9.2, 1.10.0, 1.11.0, 1.11.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.1",
  git ? { },
}:
let
  versions = {
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "debug: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "debug: unknown version '${version}'")
