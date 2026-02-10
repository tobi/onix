#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uri
#
# Versions: 0.13.0, 1.0.3, 1.0.4, 1.1.0, 1.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.1",
  git ? { },
}:
let
  versions = {
    "0.13.0" = import ./0.13.0 { inherit lib stdenv ruby; };
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
    "1.0.4" = import ./1.0.4 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "uri: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "uri: unknown version '${version}'")
