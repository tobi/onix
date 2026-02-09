#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails
#
# Available versions:
#   7.1.5.2
#
# Usage:
#   rails { version = "7.1.5.2"; }
#   rails { }  # latest (7.1.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.5.2",
  git ? { },
}:
let
  versions = {
    "7.1.5.2" = import ./7.1.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
    "60d92e4e7dfe" = import ./git-60d92e4e7dfe { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
