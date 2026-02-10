#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonapi-serializer
#
# Versions: 2.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.0",
  git ? { },
}:
let
  versions = {
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jsonapi-serializer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jsonapi-serializer: unknown version '${version}'")
