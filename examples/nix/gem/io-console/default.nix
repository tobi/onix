#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# io-console
#
# Versions: 0.6.0, 0.7.2, 0.8.0, 0.8.1, 0.8.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.2",
  git ? { },
}:
let
  versions = {
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.7.2" = import ./0.7.2 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.8.1" = import ./0.8.1 { inherit lib stdenv ruby; };
    "0.8.2" = import ./0.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "io-console: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "io-console: unknown version '${version}'")
