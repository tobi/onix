#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_mime
#
# Versions: 1.1.2, 1.1.4, 1.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.5",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
    "1.1.5" = import ./1.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mini_mime: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mini_mime: unknown version '${version}'")
