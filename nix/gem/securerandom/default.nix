#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# securerandom
#
# Versions: 0.3.2, 0.4.0, 0.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.1",
  git ? { },
}:
let
  versions = {
    "0.3.2" = import ./0.3.2 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "securerandom: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "securerandom: unknown version '${version}'")
