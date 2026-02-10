#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http-parser
#
# Versions: 1.2.1, 1.2.2, 1.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.3",
  git ? { },
}:
let
  versions = {
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http-parser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "http-parser: unknown version '${version}'")
