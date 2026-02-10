#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shopify_api
#
# Versions: 14.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "14.8.0",
  git ? { },
}:
let
  versions = {
    "14.8.0" = import ./14.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "shopify_api: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "shopify_api: unknown version '${version}'")
