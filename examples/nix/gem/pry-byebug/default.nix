#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry-byebug
#
# Versions: 3.10.1, 3.11.0, 3.12.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.12.0",
  git ? { },
}:
let
  versions = {
    "3.10.1" = import ./3.10.1 { inherit lib stdenv ruby; };
    "3.11.0" = import ./3.11.0 { inherit lib stdenv ruby; };
    "3.12.0" = import ./3.12.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pry-byebug: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pry-byebug: unknown version '${version}'")
