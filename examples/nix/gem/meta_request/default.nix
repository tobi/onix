#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# meta_request
#
# Versions: 0.8.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.5",
  git ? { },
}:
let
  versions = {
    "0.8.5" = import ./0.8.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "meta_request: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "meta_request: unknown version '${version}'")
