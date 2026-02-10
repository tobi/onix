#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# orm_adapter
#
# Versions: 0.4.1, 0.5.0
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
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "orm_adapter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "orm_adapter: unknown version '${version}'")
