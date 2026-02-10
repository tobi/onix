#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-rails
#
# Versions: 4.5.1, 4.6.0, 4.6.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.6.1",
  git ? { },
}:
let
  versions = {
    "4.5.1" = import ./4.5.1 { inherit lib stdenv ruby; };
    "4.6.0" = import ./4.6.0 { inherit lib stdenv ruby; };
    "4.6.1" = import ./4.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jquery-rails: unknown version '${version}'")
