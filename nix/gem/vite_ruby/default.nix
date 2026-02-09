#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vite_ruby
#
# Available versions:
#   3.8.0
#
# Usage:
#   vite_ruby { version = "3.8.0"; }
#   vite_ruby { }  # latest (3.8.0)
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
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vite_ruby: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "vite_ruby: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
