#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth
#
# Available versions:
#   2.1.2
#   2.1.4
#
# Usage:
#   omniauth { version = "2.1.4"; }
#   omniauth { }  # latest (2.1.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.4",
  git ? { },
}:
let
  versions = {
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.1.4" = import ./2.1.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "omniauth: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
