#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sixarm_ruby_unaccent
#
# Versions: 1.1.2, 1.2.0, 1.2.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.2",
  git ? { },
}:
let
  versions = {
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
    "1.2.2" = import ./1.2.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sixarm_ruby_unaccent: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sixarm_ruby_unaccent: unknown version '${version}'")
