#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n-tasks
#
# Versions: 0.9.37, 1.0.13, 1.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.2",
  git ? { },
}:
let
  versions = {
    "0.9.37" = import ./0.9.37 { inherit lib stdenv ruby; };
    "1.0.13" = import ./1.0.13 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "i18n-tasks: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "i18n-tasks: unknown version '${version}'")
