#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n-js
#
# Versions: 3.9.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.2",
  git ? { },
}:
let
  versions = {
    "3.9.2" = import ./3.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "i18n-js: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "i18n-js: unknown version '${version}'")
