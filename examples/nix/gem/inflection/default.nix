#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# inflection
#
# Versions: 1.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.0",
  git ? { },
}:
let
  versions = {
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "inflection: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "inflection: unknown version '${version}'")
