#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-schema
#
# Versions: 2.8.1, 5.2.2, 6.0.0, 6.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.0",
  git ? { },
}:
let
  versions = {
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "5.2.2" = import ./5.2.2 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "json-schema: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "json-schema: unknown version '${version}'")
