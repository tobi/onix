#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# action_text-trix
#
# Available versions:
#   2.1.16
#
# Usage:
#   action_text-trix { version = "2.1.16"; }
#   action_text-trix { }  # latest (2.1.16)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.16",
  git ? { },
}:
let
  versions = {
    "2.1.16" = import ./2.1.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "action_text-trix: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "action_text-trix: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
