#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-dsl
#
# Versions: 0.1.10
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.10",
  git ? { },
}:
let
  versions = {
    "0.1.10" = import ./0.1.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "elasticsearch-dsl: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "elasticsearch-dsl: unknown version '${version}'")
