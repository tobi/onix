#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n
#
# Versions: 1.14.6, 1.14.7, 1.14.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.14.8",
  git ? { },
}:
let
  versions = {
    "1.14.6" = import ./1.14.6 { inherit lib stdenv ruby; };
    "1.14.7" = import ./1.14.7 { inherit lib stdenv ruby; };
    "1.14.8" = import ./1.14.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "i18n: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "i18n: unknown version '${version}'")
