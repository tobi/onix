#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-statistics
#
# Versions: 3.0.0, 4.0.0, 4.0.1, 4.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.0",
  git ? { },
}:
let
  versions = {
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-statistics: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-statistics: unknown version '${version}'")
