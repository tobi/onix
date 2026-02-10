#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webdrivers
#
# Versions: 5.2.0, 5.3.0, 5.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.3.1",
  git ? { },
}:
let
  versions = {
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webdrivers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webdrivers: unknown version '${version}'")
