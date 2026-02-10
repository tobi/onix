#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# css_parser
#
# Versions: 1.20.0, 1.21.0, 1.21.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.21.1",
  git ? { },
}:
let
  versions = {
    "1.20.0" = import ./1.20.0 { inherit lib stdenv ruby; };
    "1.21.0" = import ./1.21.0 { inherit lib stdenv ruby; };
    "1.21.1" = import ./1.21.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "css_parser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "css_parser: unknown version '${version}'")
