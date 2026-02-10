#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# requestjs-rails
#
# Versions: 0.0.14
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.14",
  git ? { },
}:
let
  versions = {
    "0.0.14" = import ./0.0.14 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "requestjs-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "requestjs-rails: unknown version '${version}'")
