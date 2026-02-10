#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# view_component
#
# Versions: 3.24.0, 4.1.0, 4.1.1, 4.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.0",
  git ? { },
}:
let
  versions = {
    "3.24.0" = import ./3.24.0 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
    "4.1.1" = import ./4.1.1 { inherit lib stdenv ruby; };
    "4.2.0" = import ./4.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "view_component: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "view_component: unknown version '${version}'")
