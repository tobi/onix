#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-proxy
#
# Versions: 0.7.5, 0.7.6, 0.7.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.7",
  git ? { },
}:
let
  versions = {
    "0.7.5" = import ./0.7.5 { inherit lib stdenv ruby; };
    "0.7.6" = import ./0.7.6 { inherit lib stdenv ruby; };
    "0.7.7" = import ./0.7.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-proxy: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rack-proxy: unknown version '${version}'")
