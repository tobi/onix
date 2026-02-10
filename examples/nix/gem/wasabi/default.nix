#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wasabi
#
# Versions: 5.0.2, 5.0.3, 5.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.1.0",
  git ? { },
}:
let
  versions = {
    "5.0.2" = import ./5.0.2 { inherit lib stdenv ruby; };
    "5.0.3" = import ./5.0.3 { inherit lib stdenv ruby; };
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wasabi: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "wasabi: unknown version '${version}'")
