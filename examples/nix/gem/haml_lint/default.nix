#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haml_lint
#
# Versions: 0.67.0, 0.68.0, 0.69.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.69.0",
  git ? { },
}:
let
  versions = {
    "0.67.0" = import ./0.67.0 { inherit lib stdenv ruby; };
    "0.68.0" = import ./0.68.0 { inherit lib stdenv ruby; };
    "0.69.0" = import ./0.69.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "haml_lint: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "haml_lint: unknown version '${version}'")
