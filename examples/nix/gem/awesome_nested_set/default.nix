#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# awesome_nested_set
#
# Versions: 3.9.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.0",
  git ? { },
}:
let
  versions = {
    "3.9.0" = import ./3.9.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "awesome_nested_set: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "awesome_nested_set: unknown version '${version}'")
