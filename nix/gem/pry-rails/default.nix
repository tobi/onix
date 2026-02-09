#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry-rails
#
# Available versions:
#   0.3.9
#   0.3.11
#
# Usage:
#   pry-rails { version = "0.3.11"; }
#   pry-rails { }  # latest (0.3.11)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.11",
  git ? { },
}:
let
  versions = {
    "0.3.9" = import ./0.3.9 { inherit lib stdenv ruby; };
    "0.3.11" = import ./0.3.11 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pry-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "pry-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
