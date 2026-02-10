#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http-persistent
#
# Versions: 4.0.1, 4.0.2, 4.0.6, 4.0.7, 4.0.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.8",
  git ? { },
}:
let
  versions = {
    "4.0.1" = import ./4.0.1 { inherit lib stdenv ruby; };
    "4.0.2" = import ./4.0.2 { inherit lib stdenv ruby; };
    "4.0.6" = import ./4.0.6 { inherit lib stdenv ruby; };
    "4.0.7" = import ./4.0.7 { inherit lib stdenv ruby; };
    "4.0.8" = import ./4.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-http-persistent: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-http-persistent: unknown version '${version}'")
