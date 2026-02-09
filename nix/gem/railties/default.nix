#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# railties
#
# Available versions:
#   7.1.5.2
#   8.0.4
#
# Usage:
#   railties { version = "8.0.4"; }
#   railties { }  # latest (8.0.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.4",
  git ? { },
}:
let
  versions = {
    "7.1.5.2" = import ./7.1.5.2 { inherit lib stdenv ruby; };
    "8.0.4" = import ./8.0.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "railties: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "railties: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
