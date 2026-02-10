#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ast
#
# Versions: 2.4.1, 2.4.2, 2.4.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.4.3",
  git ? { },
}:
let
  versions = {
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
    "2.4.2" = import ./2.4.2 { inherit lib stdenv ruby; };
    "2.4.3" = import ./2.4.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ast: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ast: unknown version '${version}'")
