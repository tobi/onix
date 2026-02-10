#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# excon
#
# Versions: 0.104.0, 1.3.0, 1.3.1, 1.3.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.2",
  git ? { },
}:
let
  versions = {
    "0.104.0" = import ./0.104.0 { inherit lib stdenv ruby; };
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
    "1.3.2" = import ./1.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "excon: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "excon: unknown version '${version}'")
