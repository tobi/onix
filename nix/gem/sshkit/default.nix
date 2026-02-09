#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sshkit
#
# Available versions:
#   1.25.0
#
# Usage:
#   sshkit { version = "1.25.0"; }
#   sshkit { }  # latest (1.25.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.25.0",
  git ? { },
}:
let
  versions = {
    "1.25.0" = import ./1.25.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sshkit: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sshkit: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
