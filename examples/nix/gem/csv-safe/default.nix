#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv-safe
#
# Versions: 3.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.1",
  git ? { },
}:
let
  versions = {
    "3.3.1" = import ./3.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "csv-safe: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "csv-safe: unknown version '${version}'")
