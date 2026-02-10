#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth
#
# Versions: 0.5.10, 1.1.0, 1.1.1, 1.1.2, 1.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.3",
  git ? { },
}:
let
  versions = {
    "0.5.10" = import ./0.5.10 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.1.3" = import ./1.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "oauth: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "oauth: unknown version '${version}'")
