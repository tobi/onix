#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mimemagic
#
# Versions: 0.4.1, 0.4.2, 0.4.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.3",
  git ? { },
}:
let
  versions = {
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.4.2" = import ./0.4.2 { inherit lib stdenv ruby; };
    "0.4.3" = import ./0.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mimemagic: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mimemagic: unknown version '${version}'")
