#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solargraph
#
# Versions: 0.50.0, 0.59.0.dev.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.59.0.dev.1",
  git ? { },
}:
let
  versions = {
    "0.50.0" = import ./0.50.0 { inherit lib stdenv ruby; };
    "0.59.0.dev.1" = import ./0.59.0.dev.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solargraph: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "solargraph: unknown version '${version}'")
