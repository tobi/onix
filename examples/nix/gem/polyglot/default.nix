#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# polyglot
#
# Versions: 0.3.3, 0.3.4, 0.3.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.5",
  git ? { },
}:
let
  versions = {
    "0.3.3" = import ./0.3.3 { inherit lib stdenv ruby; };
    "0.3.4" = import ./0.3.4 { inherit lib stdenv ruby; };
    "0.3.5" = import ./0.3.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "polyglot: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "polyglot: unknown version '${version}'")
