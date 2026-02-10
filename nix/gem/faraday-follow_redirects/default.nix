#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-follow_redirects
#
# Versions: 0.3.0, 0.4.0, 0.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.0",
  git ? { },
}:
let
  versions = {
    "0.3.0" = import ./0.3.0 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-follow_redirects: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-follow_redirects: unknown version '${version}'")
