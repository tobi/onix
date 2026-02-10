#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sanitize
#
# Versions: 6.0.2, 6.1.2, 6.1.3, 7.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.0",
  git ? { },
}:
let
  versions = {
    "6.0.2" = import ./6.0.2 { inherit lib stdenv ruby; };
    "6.1.2" = import ./6.1.2 { inherit lib stdenv ruby; };
    "6.1.3" = import ./6.1.3 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sanitize: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sanitize: unknown version '${version}'")
