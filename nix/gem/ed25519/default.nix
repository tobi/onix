#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ed25519
#
# Versions: 1.2.4, 1.3.0, 1.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.0",
  git ? { },
}:
let
  versions = {
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
    "1.4.0" = import ./1.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ed25519: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ed25519: unknown version '${version}'")
