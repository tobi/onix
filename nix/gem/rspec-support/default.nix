#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-support
#
# Available versions:
#   3.13.1
#   3.13.6
#
# Usage:
#   rspec-support { version = "3.13.6"; }
#   rspec-support { }  # latest (3.13.6)
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
    "3.13.1" = import ./3.13.1 { inherit lib stdenv ruby; };
    "3.13.6" = import ./3.13.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-support: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec-support: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
