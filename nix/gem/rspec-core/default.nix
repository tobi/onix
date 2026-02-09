#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-core
#
# Available versions:
#   3.13.0
#   3.13.6
#
# Usage:
#   rspec-core { version = "3.13.6"; }
#   rspec-core { }  # latest (3.13.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.6",
  git ? { },
}:
let
  versions = {
    "3.13.0" = import ./3.13.0 { inherit lib stdenv ruby; };
    "3.13.6" = import ./3.13.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-core: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec-core: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
