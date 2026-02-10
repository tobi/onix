#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bcp47_spec
#
# Versions: 0.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.1",
  git ? { },
}:
let
  versions = {
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bcp47_spec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bcp47_spec: unknown version '${version}'")
