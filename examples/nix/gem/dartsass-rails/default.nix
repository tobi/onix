#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dartsass-rails
#
# Versions: 0.5.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.1",
  git ? { },
}:
let
  versions = {
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "dartsass-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "dartsass-rails: unknown version '${version}'")
