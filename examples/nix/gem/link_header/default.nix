#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# link_header
#
# Versions: 0.0.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.8",
  git ? { },
}:
let
  versions = {
    "0.0.8" = import ./0.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "link_header: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "link_header: unknown version '${version}'")
