#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# audited
#
# Versions: 5.4.1
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
    "5.4.1" = import ./5.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "audited: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "audited: unknown version '${version}'")
