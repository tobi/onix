#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# asciidoctor
#
# Versions: 2.0.24, 2.0.25, 2.0.26
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.26",
  git ? { },
}:
let
  versions = {
    "2.0.24" = import ./2.0.24 { inherit lib stdenv ruby; };
    "2.0.25" = import ./2.0.25 { inherit lib stdenv ruby; };
    "2.0.26" = import ./2.0.26 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "asciidoctor: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "asciidoctor: unknown version '${version}'")
