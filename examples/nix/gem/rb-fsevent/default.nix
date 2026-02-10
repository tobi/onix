#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-fsevent
#
# Versions: 0.11.0, 0.11.1, 0.11.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.2",
  git ? { },
}:
let
  versions = {
    "0.11.0" = import ./0.11.0 { inherit lib stdenv ruby; };
    "0.11.1" = import ./0.11.1 { inherit lib stdenv ruby; };
    "0.11.2" = import ./0.11.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb-fsevent: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rb-fsevent: unknown version '${version}'")
