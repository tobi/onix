#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# maxminddb
#
# Versions: 0.1.22
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.22",
  git ? { },
}:
let
  versions = {
    "0.1.22" = import ./0.1.22 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "maxminddb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "maxminddb: unknown version '${version}'")
