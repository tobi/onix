#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cssbundling-rails
#
# Versions: 1.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.4.1",
  git ? { },
}:
let
  versions = {
    "1.4.1" = import ./1.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cssbundling-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cssbundling-rails: unknown version '${version}'")
