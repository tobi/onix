#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-httpclient
#
# Versions: 2.0.0, 2.0.1, 2.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.2",
  git ? { },
}:
let
  versions = {
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.0.1" = import ./2.0.1 { inherit lib stdenv ruby; };
    "2.0.2" = import ./2.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-httpclient: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-httpclient: unknown version '${version}'")
