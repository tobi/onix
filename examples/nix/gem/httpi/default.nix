#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httpi
#
# Versions: 4.0.2, 4.0.3, 4.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.4",
  git ? { },
}:
let
  versions = {
    "4.0.2" = import ./4.0.2 { inherit lib stdenv ruby; };
    "4.0.3" = import ./4.0.3 { inherit lib stdenv ruby; };
    "4.0.4" = import ./4.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "httpi: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "httpi: unknown version '${version}'")
