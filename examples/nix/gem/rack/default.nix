#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack
#
# Versions: 2.2.10, 2.2.21, 3.0.0.rc1, 3.2.1, 3.2.2, 3.2.3, 3.2.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2.4",
  git ? { },
}:
let
  versions = {
    "2.2.10" = import ./2.2.10 { inherit lib stdenv ruby; };
    "2.2.21" = import ./2.2.21 { inherit lib stdenv ruby; };
    "3.0.0.rc1" = import ./3.0.0.rc1 { inherit lib stdenv ruby; };
    "3.2.1" = import ./3.2.1 { inherit lib stdenv ruby; };
    "3.2.2" = import ./3.2.2 { inherit lib stdenv ruby; };
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
    "3.2.4" = import ./3.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rack: unknown version '${version}'")
