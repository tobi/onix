#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pastel
#
# Versions: 0.7.3, 0.7.4, 0.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.8.0",
  git ? { },
}:
let
  versions = {
    "0.7.3" = import ./0.7.3 { inherit lib stdenv ruby; };
    "0.7.4" = import ./0.7.4 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pastel: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pastel: unknown version '${version}'")
