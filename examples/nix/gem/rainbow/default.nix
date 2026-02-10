#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rainbow
#
# Versions: 3.0.0, 3.1.0, 3.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.1",
  git ? { },
}:
let
  versions = {
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.1" = import ./3.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rainbow: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rainbow: unknown version '${version}'")
