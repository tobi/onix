#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erb-formatter
#
# Versions: 0.7.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.3",
  git ? { },
}:
let
  versions = {
    "0.7.3" = import ./0.7.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "erb-formatter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "erb-formatter: unknown version '${version}'")
