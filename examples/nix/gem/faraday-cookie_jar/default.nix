#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-cookie_jar
#
# Versions: 0.0.6, 0.0.7, 0.0.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.8",
  git ? { },
}:
let
  versions = {
    "0.0.6" = import ./0.0.6 { inherit lib stdenv ruby; };
    "0.0.7" = import ./0.0.7 { inherit lib stdenv ruby; };
    "0.0.8" = import ./0.0.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-cookie_jar: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-cookie_jar: unknown version '${version}'")
