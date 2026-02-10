#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# word_wrap
#
# Versions: 0.2.1, 0.2.2, 1.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.0",
  git ? { },
}:
let
  versions = {
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
    "0.2.2" = import ./0.2.2 { inherit lib stdenv ruby; };
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "word_wrap: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "word_wrap: unknown version '${version}'")
