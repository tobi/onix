#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails
#
# Available versions:
#   7.0.8.7
#   7.1.5.2
#   8.0.3
#   8.1.0
#   8.1.1
#   8.1.2
#
# Usage:
#   rails { version = "8.1.2"; }
#   rails { }  # latest (8.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.2",
  git ? { },
}:
let
  versions = {
    "7.0.8.7" = import ./7.0.8.7 { inherit lib stdenv ruby; };
    "7.1.5.2" = import ./7.1.5.2 { inherit lib stdenv ruby; };
    "8.0.3" = import ./8.0.3 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
    "8.1.1" = import ./8.1.1 { inherit lib stdenv ruby; };
    "8.1.2" = import ./8.1.2 { inherit lib stdenv ruby; };
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
