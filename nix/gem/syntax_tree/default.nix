#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# syntax_tree
#
# Versions: 6.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.3.0",
  git ? { },
}:
let
  versions = {
    "6.3.0" = import ./6.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "syntax_tree: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "syntax_tree: unknown version '${version}'")
