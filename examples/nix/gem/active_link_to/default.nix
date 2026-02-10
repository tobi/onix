#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_link_to
#
# Versions: 1.0.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.5",
  git ? { },
}:
let
  versions = {
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "active_link_to: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "active_link_to: unknown version '${version}'")
