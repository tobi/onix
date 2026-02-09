#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cache
#
# Available versions:
#   1.0.10
#
# Usage:
#   solid_cache { version = "1.0.10"; }
#   solid_cache { }  # latest (1.0.10)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.10",
  git ? { },
}:
let
  versions = {
    "1.0.10" = import ./1.0.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solid_cache: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "solid_cache: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
