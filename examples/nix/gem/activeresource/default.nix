#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activeresource
#
# Versions: 6.1.3, 6.1.4, 6.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.2.0",
  git ? { },
}:
let
  versions = {
    "6.1.3" = import ./6.1.3 { inherit lib stdenv ruby; };
    "6.1.4" = import ./6.1.4 { inherit lib stdenv ruby; };
    "6.2.0" = import ./6.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "activeresource: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "activeresource: unknown version '${version}'")
