#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails-i18n
#
# Versions: 7.0.8, 8.0.1, 8.0.2, 8.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.0",
  git ? { },
}:
let
  versions = {
    "7.0.8" = import ./7.0.8 { inherit lib stdenv ruby; };
    "8.0.1" = import ./8.0.1 { inherit lib stdenv ruby; };
    "8.0.2" = import ./8.0.2 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rails-i18n: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rails-i18n: unknown version '${version}'")
