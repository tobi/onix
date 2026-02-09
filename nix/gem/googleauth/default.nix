#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleauth
#
# Available versions:
#   1.11.2
#
# Usage:
#   googleauth { version = "1.11.2"; }
#   googleauth { }  # latest (1.11.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.11.2",
  git ? { },
}:
let
  versions = {
    "1.11.2" = import ./1.11.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "googleauth: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "googleauth: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
