#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# octokit
#
# Available versions:
#   5.6.1
#
# Usage:
#   octokit { version = "5.6.1"; }
#   octokit { }  # latest (5.6.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.6.1",
  git ? { },
}:
let
  versions = {
    "5.6.1" = import ./5.6.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "octokit: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "octokit: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
