#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sigv4
#
# Available versions:
#   1.12.1
#
# Usage:
#   aws-sigv4 { version = "1.12.1"; }
#   aws-sigv4 { }  # latest (1.12.1)
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
    "1.12.1" = import ./1.12.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sigv4: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "aws-sigv4: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
