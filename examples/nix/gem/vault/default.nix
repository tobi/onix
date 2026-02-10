#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vault
#
# Versions: 0.18.2, 0.19.0, 0.20.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.20.0",
  git ? { },
}:
let
  versions = {
    "0.18.2" = import ./0.18.2 { inherit lib stdenv ruby; };
    "0.19.0" = import ./0.19.0 { inherit lib stdenv ruby; };
    "0.20.0" = import ./0.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vault: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "vault: unknown version '${version}'")
