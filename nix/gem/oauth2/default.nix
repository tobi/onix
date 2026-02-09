#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth2
#
# Available versions:
#   1.4.11
#   2.0.9
#
# Usage:
#   oauth2 { version = "2.0.9"; }
#   oauth2 { }  # latest (2.0.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.9",
  git ? { },
}:
let
  versions = {
    "1.4.11" = import ./1.4.11 { inherit lib stdenv ruby; };
    "2.0.9" = import ./2.0.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "oauth2: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "oauth2: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
