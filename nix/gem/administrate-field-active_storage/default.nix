#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# administrate-field-active_storage
#
# Versions: 1.0.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.3",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "administrate-field-active_storage: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "administrate-field-active_storage: unknown version '${version}'")
