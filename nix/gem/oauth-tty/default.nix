#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth-tty
#
# Available versions:
#   1.0.5
#   1.0.6
#
# Usage:
#   oauth-tty { version = "1.0.6"; }
#   oauth-tty { }  # latest (1.0.6)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.6",
  git ? { },
}:
let
  versions = {
    "1.0.5" = import ./1.0.5 { inherit lib stdenv ruby; };
    "1.0.6" = import ./1.0.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "oauth-tty: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "oauth-tty: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
