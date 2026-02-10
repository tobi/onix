#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# semantic_range
#
# Versions: 2.3.1, 3.0.0, 3.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.0",
  git ? { },
}:
let
  versions = {
    "2.3.1" = import ./2.3.1 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "semantic_range: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "semantic_range: unknown version '${version}'")
