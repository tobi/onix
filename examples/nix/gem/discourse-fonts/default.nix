#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-fonts
#
# Versions: 0.0.19
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.19",
  git ? { },
}:
let
  versions = {
    "0.0.19" = import ./0.0.19 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse-fonts: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discourse-fonts: unknown version '${version}'")
