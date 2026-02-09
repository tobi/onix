#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise
#
# Available versions:
#   4.9.4
#
# Usage:
#   devise { version = "4.9.4"; }
#   devise { }  # latest (4.9.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.9.4",
  git ? { },
}:
let
  versions = {
    "4.9.4" = import ./4.9.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "devise: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
