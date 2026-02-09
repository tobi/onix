#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rspec_rails
#
# Available versions:
#   2.32.0
#
# Usage:
#   rubocop-rspec_rails { version = "2.32.0"; }
#   rubocop-rspec_rails { }  # latest (2.32.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.32.0",
  git ? { },
}:
let
  versions = {
    "2.32.0" = import ./2.32.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-rspec_rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-rspec_rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
