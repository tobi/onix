#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cbor
#
# Versions: 0.5.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.10.1",
  git ? { },
}:
let
  versions = {
    "0.5.10.1" = import ./0.5.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cbor: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cbor: unknown version '${version}'")
