#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# awesome_print
#
# Versions: 1.7.0, 1.8.0, 1.9.2, 2.0.0.pre2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0.pre2",
  git ? { },
}:
let
  versions = {
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
    "2.0.0.pre2" = import ./2.0.0.pre2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "awesome_print: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "awesome_print: unknown version '${version}'")
