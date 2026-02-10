#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# judoscale-rails
#
# Versions: 1.8.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.2",
  git ? { },
}:
let
  versions = {
    "1.8.2" = import ./1.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "judoscale-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "judoscale-rails: unknown version '${version}'")
