#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# version_gem
#
# Available versions:
#   1.1.4
#   1.1.9
#
# Usage:
#   version_gem { version = "1.1.9"; }
#   version_gem { }  # latest (1.1.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.9",
  git ? { },
}:
let
  versions = {
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
    "1.1.9" = import ./1.1.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "version_gem: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "version_gem: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
