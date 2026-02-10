#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tailwindcss-rails
#
# Versions: 3.2.0, 3.3.2, 4.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.4.0",
  git ? { },
}:
let
  versions = {
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.3.2" = import ./3.3.2 { inherit lib stdenv ruby; };
    "4.4.0" = import ./4.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tailwindcss-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tailwindcss-rails: unknown version '${version}'")
