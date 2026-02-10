#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# better_errors
#
# Versions: 2.9.1, 2.10.0, 2.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.10.1",
  git ? { },
}:
let
  versions = {
    "2.9.1" = import ./2.9.1 { inherit lib stdenv ruby; };
    "2.10.0" = import ./2.10.0 { inherit lib stdenv ruby; };
    "2.10.1" = import ./2.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "better_errors: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "better_errors: unknown version '${version}'")
