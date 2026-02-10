#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pdf-core
#
# Versions: 0.8.1, 0.9.0, 0.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.10.0",
  git ? { },
}:
let
  versions = {
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.10.0" = import ./0.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pdf-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pdf-core: unknown version '${version}'")
