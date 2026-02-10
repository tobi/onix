#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphql-client
#
# Versions: 0.24.0, 0.25.0, 0.26.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.26.0",
  git ? { },
}:
let
  versions = {
    "0.24.0" = import ./0.24.0 { inherit lib stdenv ruby; };
    "0.25.0" = import ./0.25.0 { inherit lib stdenv ruby; };
    "0.26.0" = import ./0.26.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "graphql-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "graphql-client: unknown version '${version}'")
