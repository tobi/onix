#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper
#
# Versions: 0.25.4, 1.3.4, 1.3.5, 1.3.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.6",
  git ? { },
}:
let
  versions = {
    "0.25.4" = import ./0.25.4 { inherit lib stdenv ruby; };
    "1.3.4" = import ./1.3.4 { inherit lib stdenv ruby; };
    "1.3.5" = import ./1.3.5 { inherit lib stdenv ruby; };
    "1.3.6" = import ./1.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flipper: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "flipper: unknown version '${version}'")
