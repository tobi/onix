#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simple_form
#
# Versions: 5.3.1, 5.4.0, 5.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.4.1",
  git ? { },
}:
let
  versions = {
    "5.3.1" = import ./5.3.1 { inherit lib stdenv ruby; };
    "5.4.0" = import ./5.4.0 { inherit lib stdenv ruby; };
    "5.4.1" = import ./5.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simple_form: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "simple_form: unknown version '${version}'")
