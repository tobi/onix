#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# scss_lint
#
# Versions: 0.60.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.60.0",
  git ? { },
}:
let
  versions = {
    "0.60.0" = import ./0.60.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "scss_lint: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "scss_lint: unknown version '${version}'")
