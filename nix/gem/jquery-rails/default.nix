#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-rails
#
# Available versions:
#   4.6.0
#
# Usage:
#   jquery-rails { version = "4.6.0"; }
#   jquery-rails { }  # latest (4.6.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.6.0",
  git ? { },
}:
let
  versions = {
    "4.6.0" = import ./4.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "jquery-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
