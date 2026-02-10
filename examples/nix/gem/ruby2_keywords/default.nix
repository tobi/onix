#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby2_keywords
#
# Versions: 0.0.3, 0.0.4, 0.0.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.5",
  git ? { },
}:
let
  versions = {
    "0.0.3" = import ./0.0.3 { inherit lib stdenv ruby; };
    "0.0.4" = import ./0.0.4 { inherit lib stdenv ruby; };
    "0.0.5" = import ./0.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby2_keywords: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby2_keywords: unknown version '${version}'")
