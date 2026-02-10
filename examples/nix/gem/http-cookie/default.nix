#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-cookie
#
# Versions: 1.0.5, 1.0.7, 1.0.8, 1.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.0",
  git ? { },
}:
let
  versions = {
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.0.7" = import ./1.0.7 { inherit lib stdenv ruby; };
    "1.0.8" = import ./1.0.8 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-cookie: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "http-cookie: unknown version '${version}'")
