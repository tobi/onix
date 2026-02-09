#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-rspec
#
# Available versions:
#   3.6.0
#   3.8.0
#
# Usage:
#   rubocop-rspec { version = "3.8.0"; }
#   rubocop-rspec { }  # latest (3.8.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.8.0",
  git ? { },
}:
let
  versions = {
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rubocop-rspec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rubocop-rspec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
