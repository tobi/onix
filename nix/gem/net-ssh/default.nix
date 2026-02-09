#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-ssh
#
# Available versions:
#   7.3.0
#
# Usage:
#   net-ssh { version = "7.3.0"; }
#   net-ssh { }  # latest (7.3.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.3.0",
  git ? { },
}:
let
  versions = {
    "7.3.0" = import ./7.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-ssh: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "net-ssh: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
