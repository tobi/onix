#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selectize-rails
#
# Available versions:
#   0.12.6
#
# Usage:
#   selectize-rails { version = "0.12.6"; }
#   selectize-rails { }  # latest (0.12.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.12.6",
  git ? { },
}:
let
  versions = {
    "0.12.6" = import ./0.12.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "selectize-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "selectize-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
