#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# base64
#
# Versions: 0.1.2, 0.2.0, 0.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.0",
  git ? { },
}:
let
  versions = {
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
    "0.3.0" = import ./0.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "base64: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "base64: unknown version '${version}'")
