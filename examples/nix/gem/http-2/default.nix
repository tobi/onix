#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-2
#
# Versions: 0.11.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.0",
  git ? { },
}:
let
  versions = {
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "http-2: unknown version '${version}'")
