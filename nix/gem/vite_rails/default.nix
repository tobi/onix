#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vite_rails
#
# Versions: 3.0.17, 3.0.20
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.20",
  git ? { },
}:
let
  versions = {
    "3.0.17" = import ./3.0.17 { inherit lib stdenv ruby; };
    "3.0.20" = import ./3.0.20 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vite_rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "vite_rails: unknown version '${version}'")
