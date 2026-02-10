#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe
#
# Versions: 5.55.0, 11.1.0, 18.0.1, 18.2.0, 18.3.0, 18.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "18.3.1",
  git ? { },
}:
let
  versions = {
    "5.55.0" = import ./5.55.0 { inherit lib stdenv ruby; };
    "11.1.0" = import ./11.1.0 { inherit lib stdenv ruby; };
    "18.0.1" = import ./18.0.1 { inherit lib stdenv ruby; };
    "18.2.0" = import ./18.2.0 { inherit lib stdenv ruby; };
    "18.3.0" = import ./18.3.0 { inherit lib stdenv ruby; };
    "18.3.1" = import ./18.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stripe: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "stripe: unknown version '${version}'")
