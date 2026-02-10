#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ostruct
#
# Versions: 0.6.1, 0.6.2, 0.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.3",
  git ? { },
}:
let
  versions = {
    "0.6.1" = import ./0.6.1 { inherit lib stdenv ruby; };
    "0.6.2" = import ./0.6.2 { inherit lib stdenv ruby; };
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ostruct: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ostruct: unknown version '${version}'")
