#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# treetop
#
# Versions: 1.6.16, 1.6.17, 1.6.18
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.18",
  git ? { },
}:
let
  versions = {
    "1.6.16" = import ./1.6.16 { inherit lib stdenv ruby; };
    "1.6.17" = import ./1.6.17 { inherit lib stdenv ruby; };
    "1.6.18" = import ./1.6.18 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "treetop: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "treetop: unknown version '${version}'")
