#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backports
#
# Versions: 3.25.1, 3.25.2, 3.25.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.25.3",
  git ? { },
}:
let
  versions = {
    "3.25.1" = import ./3.25.1 { inherit lib stdenv ruby; };
    "3.25.2" = import ./3.25.2 { inherit lib stdenv ruby; };
    "3.25.3" = import ./3.25.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "backports: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "backports: unknown version '${version}'")
