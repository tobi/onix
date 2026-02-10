#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-graphviz
#
# Versions: 1.2.3, 1.2.4, 1.2.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.5",
  git ? { },
}:
let
  versions = {
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
    "1.2.5" = import ./1.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-graphviz: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-graphviz: unknown version '${version}'")
