#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# guard-rspec
#
# Versions: 4.7.1, 4.7.2, 4.7.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.7.3",
  git ? { },
}:
let
  versions = {
    "4.7.1" = import ./4.7.1 { inherit lib stdenv ruby; };
    "4.7.2" = import ./4.7.2 { inherit lib stdenv ruby; };
    "4.7.3" = import ./4.7.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "guard-rspec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "guard-rspec: unknown version '${version}'")
