#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cucumber-core
#
# Versions: 16.0.0, 16.1.1, 16.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "16.2.0",
  git ? { },
}:
let
  versions = {
    "16.0.0" = import ./16.0.0 { inherit lib stdenv ruby; };
    "16.1.1" = import ./16.1.1 { inherit lib stdenv ruby; };
    "16.2.0" = import ./16.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cucumber-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cucumber-core: unknown version '${version}'")
