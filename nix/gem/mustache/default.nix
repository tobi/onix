#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mustache
#
# Versions: 1.0.5, 1.1.0, 1.1.1
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
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mustache: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mustache: unknown version '${version}'")
