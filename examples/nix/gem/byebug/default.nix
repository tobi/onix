#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# byebug
#
# Versions: 11.1.3, 12.0.0, 13.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "13.0.0",
  git ? { },
}:
let
  versions = {
    "11.1.3" = import ./11.1.3 { inherit lib stdenv ruby; };
    "12.0.0" = import ./12.0.0 { inherit lib stdenv ruby; };
    "13.0.0" = import ./13.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "byebug: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "byebug: unknown version '${version}'")
