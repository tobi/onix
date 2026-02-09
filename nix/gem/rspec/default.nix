#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec
#
# Available versions:
#   3.13.2
#
# Usage:
#   rspec { version = "3.13.2"; }
#   rspec { }  # latest (3.13.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.13.2",
  git ? { },
}:
let
  versions = {
    "3.13.2" = import ./3.13.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rspec: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
