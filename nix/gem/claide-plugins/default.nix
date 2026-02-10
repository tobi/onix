#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# claide-plugins
#
# Versions: 0.9.0, 0.9.1, 0.9.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.2",
  git ? { },
}:
let
  versions = {
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.9.1" = import ./0.9.1 { inherit lib stdenv ruby; };
    "0.9.2" = import ./0.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "claide-plugins: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "claide-plugins: unknown version '${version}'")
