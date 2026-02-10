#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper-ui
#
# Versions: 0.25.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.25.4",
  git ? { },
}:
let
  versions = {
    "0.25.4" = import ./0.25.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "flipper-ui: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "flipper-ui: unknown version '${version}'")
