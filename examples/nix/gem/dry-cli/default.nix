#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-cli
#
# Versions: 1.1.0, 1.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.0",
  git ? { },
}:
let
  versions = {
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dry-cli: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dry-cli: unknown version '${version}'")
