#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zip_kit
#
# Versions: 6.3.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.3.4",
  git ? { },
}:
let
  versions = {
    "6.3.4" = import ./6.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "zip_kit: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "zip_kit: unknown version '${version}'")
