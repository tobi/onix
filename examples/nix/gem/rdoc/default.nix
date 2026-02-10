#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdoc
#
# Versions: 6.6.3.1, 6.15.0, 6.17.0, 7.0.2, 7.0.3, 7.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.0",
  git ? { },
}:
let
  versions = {
    "6.6.3.1" = import ./6.6.3.1 { inherit lib stdenv ruby; };
    "6.15.0" = import ./6.15.0 { inherit lib stdenv ruby; };
    "6.17.0" = import ./6.17.0 { inherit lib stdenv ruby; };
    "7.0.2" = import ./7.0.2 { inherit lib stdenv ruby; };
    "7.0.3" = import ./7.0.3 { inherit lib stdenv ruby; };
    "7.1.0" = import ./7.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rdoc: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rdoc: unknown version '${version}'")
