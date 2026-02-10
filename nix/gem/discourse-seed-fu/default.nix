#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-seed-fu
#
# Versions: 2.3.12
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.12",
  git ? { },
}:
let
  versions = {
    "2.3.12" = import ./2.3.12 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse-seed-fu: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discourse-seed-fu: unknown version '${version}'")
