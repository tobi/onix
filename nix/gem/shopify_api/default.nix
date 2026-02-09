#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shopify_api
#
# Available versions:
#   14.8.0
#
# Usage:
#   shopify_api { version = "14.8.0"; }
#   shopify_api { }  # latest (14.8.0)
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
    or (throw "shopify_api: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "shopify_api: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
