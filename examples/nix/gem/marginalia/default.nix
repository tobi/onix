#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# marginalia
#
# Versions: 1.10.1, 1.11.0, 1.11.1
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
    "1.10.1" = import ./1.10.1 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "marginalia: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "marginalia: unknown version '${version}'")
