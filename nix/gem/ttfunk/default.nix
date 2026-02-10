#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ttfunk
#
# Versions: 1.6.2.1, 1.7.0, 1.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.0",
  git ? { },
}:
let
  versions = {
    "1.6.2.1" = import ./1.6.2.1 { inherit lib stdenv ruby; };
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ttfunk: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ttfunk: unknown version '${version}'")
