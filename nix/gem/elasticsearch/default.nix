#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch
#
# Versions: 7.17.11, 9.1.3, 9.2.0, 9.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.3.0",
  git ? { },
}:
let
  versions = {
    "7.17.11" = import ./7.17.11 { inherit lib stdenv ruby; };
    "9.1.3" = import ./9.1.3 { inherit lib stdenv ruby; };
    "9.2.0" = import ./9.2.0 { inherit lib stdenv ruby; };
    "9.3.0" = import ./9.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "elasticsearch: unknown version '${version}'")
