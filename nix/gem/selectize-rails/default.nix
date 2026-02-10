#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selectize-rails
#
# Versions: 0.12.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.12.6",
  git ? { },
}:
let
  versions = {
    "0.12.6" = import ./0.12.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "selectize-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "selectize-rails: unknown version '${version}'")
