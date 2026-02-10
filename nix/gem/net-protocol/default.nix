#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-protocol
#
# Versions: 0.2.0, 0.2.1, 0.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.2",
  git ? { },
}:
let
  versions = {
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
    "0.2.2" = import ./0.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-protocol: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-protocol: unknown version '${version}'")
