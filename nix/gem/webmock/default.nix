#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webmock
#
# Versions: 3.23.0, 3.23.1, 3.25.0, 3.25.1, 3.25.2, 3.26.0, 3.26.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.26.1",
  git ? { },
}:
let
  versions = {
    "3.23.0" = import ./3.23.0 { inherit lib stdenv ruby; };
    "3.23.1" = import ./3.23.1 { inherit lib stdenv ruby; };
    "3.25.0" = import ./3.25.0 { inherit lib stdenv ruby; };
    "3.25.1" = import ./3.25.1 { inherit lib stdenv ruby; };
    "3.25.2" = import ./3.25.2 { inherit lib stdenv ruby; };
    "3.26.0" = import ./3.26.0 { inherit lib stdenv ruby; };
    "3.26.1" = import ./3.26.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webmock: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webmock: unknown version '${version}'")
