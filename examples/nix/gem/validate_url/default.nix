#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validate_url
#
# Versions: 1.0.13, 1.0.14, 1.0.15
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.15",
  git ? { },
}:
let
  versions = {
    "1.0.13" = import ./1.0.13 { inherit lib stdenv ruby; };
    "1.0.14" = import ./1.0.14 { inherit lib stdenv ruby; };
    "1.0.15" = import ./1.0.15 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "validate_url: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "validate_url: unknown version '${version}'")
