#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-shopify
#
# Versions: 2.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.18.0",
  git ? { },
}:
let
  versions = {
    "2.18.0" = import ./2.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-shopify: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rubocop-shopify: unknown version '${version}'")
