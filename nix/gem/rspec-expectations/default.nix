#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-expectations
#
# Available versions:
#   3.13.2
#   3.13.5
#
# Usage:
#   rspec-expectations { version = "3.13.5"; }
#   rspec-expectations { }  # latest (3.13.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.5",
  git ? { },
}:
let
  versions = {
    "3.13.2" = import ./3.13.2 { inherit lib stdenv ruby; };
    "3.13.5" = import ./3.13.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-expectations: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec-expectations: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
