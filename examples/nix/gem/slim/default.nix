#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slim
#
# Versions: 5.1.1, 5.2.0, 5.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.1",
  git ? { },
}:
let
  versions = {
    "5.1.1" = import ./5.1.1 { inherit lib stdenv ruby; };
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
    "5.2.1" = import ./5.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "slim: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "slim: unknown version '${version}'")
