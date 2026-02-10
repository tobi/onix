#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unf_ext
#
# Versions: 0.0.8.2, 0.0.9, 0.0.9.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.9.1",
  git ? { },
}:
let
  versions = {
    "0.0.8.2" = import ./0.0.8.2 { inherit lib stdenv ruby; };
    "0.0.9" = import ./0.0.9 { inherit lib stdenv ruby; };
    "0.0.9.1" = import ./0.0.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unf_ext: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "unf_ext: unknown version '${version}'")
