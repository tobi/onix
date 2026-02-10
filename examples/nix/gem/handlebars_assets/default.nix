#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# handlebars_assets
#
# Versions: 0.23.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.23.9",
  git ? { },
}:
let
  versions = {
    "0.23.9" = import ./0.23.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "handlebars_assets: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "handlebars_assets: unknown version '${version}'")
