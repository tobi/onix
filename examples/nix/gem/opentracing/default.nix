#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentracing
#
# Versions: 0.4.2, 0.4.3, 0.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.0",
  git ? { },
}:
let
  versions = {
    "0.4.2" = import ./0.4.2 { inherit lib stdenv ruby; };
    "0.4.3" = import ./0.4.3 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentracing: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentracing: unknown version '${version}'")
