#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-config
#
# Versions: 3.0.6, 3.0.9, 3.0.27
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.27",
  git ? { },
}:
let
  versions = {
    "3.0.6" = import ./3.0.6 { inherit lib stdenv ruby; };
    "3.0.9" = import ./3.0.9 { inherit lib stdenv ruby; };
    "3.0.27" = import ./3.0.27 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mixlib-config: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mixlib-config: unknown version '${version}'")
