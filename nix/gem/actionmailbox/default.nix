#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionmailbox
#
# Available versions:
#   7.1.5.2
#
# Usage:
#   actionmailbox { version = "7.1.5.2"; }
#   actionmailbox { }  # latest (7.1.5.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.5.2",
  git ? { },
}:
let
  versions = {
    "7.1.5.2" = import ./7.1.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "actionmailbox: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "actionmailbox: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
