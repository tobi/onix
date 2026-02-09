#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rake-compiler-dock
#
# Available versions:
#   1.10.0
#
# Usage:
#   rake-compiler-dock { version = "1.10.0"; }
#   rake-compiler-dock { }  # latest (1.10.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.10.0",
  git ? { },
}:
let
  versions = {
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rake-compiler-dock: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rake-compiler-dock: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
