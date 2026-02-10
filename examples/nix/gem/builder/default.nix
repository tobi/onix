#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# builder
#
# Versions: 3.2.3, 3.2.4, 3.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.0",
  git ? { },
}:
let
  versions = {
    "3.2.3" = import ./3.2.3 { inherit lib stdenv ruby; };
    "3.2.4" = import ./3.2.4 { inherit lib stdenv ruby; };
    "3.3.0" = import ./3.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "builder: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "builder: unknown version '${version}'")
