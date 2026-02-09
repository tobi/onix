#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# turbo-rails
#
# Available versions:
#   2.0.21
#
# Usage:
#   turbo-rails { version = "2.0.21"; }
#   turbo-rails { }  # latest (2.0.21)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.21",
  git ? { },
}:
let
  versions = {
    "2.0.21" = import ./2.0.21 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "turbo-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "turbo-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
