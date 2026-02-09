#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fugit
#
# Available versions:
#   1.11.1
#   1.12.1
#
# Usage:
#   fugit { version = "1.12.1"; }
#   fugit { }  # latest (1.12.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.12.1",
  git ? { },
}:
let
  versions = {
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
    "1.12.1" = import ./1.12.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fugit: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "fugit: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
