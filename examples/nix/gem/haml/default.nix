#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haml
#
# Versions: 7.0.2, 7.1.0, 7.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.2.0",
  git ? { },
}:
let
  versions = {
    "7.0.2" = import ./7.0.2 { inherit lib stdenv ruby; };
    "7.1.0" = import ./7.1.0 { inherit lib stdenv ruby; };
    "7.2.0" = import ./7.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "haml: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "haml: unknown version '${version}'")
