#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mocha
#
# Versions: 2.8.2, 3.0.0, 3.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.1",
  git ? { },
}:
let
  versions = {
    "2.8.2" = import ./2.8.2 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mocha: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mocha: unknown version '${version}'")
