#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-em_http
#
# Versions: 1.0.0, 2.0.0, 2.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.1",
  git ? { },
}:
let
  versions = {
    "1.0.0" = import ./1.0.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-em_http: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-em_http: unknown version '${version}'")
