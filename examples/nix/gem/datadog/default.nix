#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# datadog
#
# Versions: 2.19.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.19.0",
  git ? { },
}:
let
  versions = {
    "2.19.0" = import ./2.19.0 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "datadog: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "datadog: unknown version '${version}'")
