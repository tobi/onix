#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lexxy (git only)
#
# Available git revs:
#   4f0fc4d5773b
#
# Usage:
#   lexxy { git.rev = "4f0fc4d5773b"; }
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? null,
  git ? { },
}:
let
  versions = { };

  gitRevs = {
    "4f0fc4d5773b" = import ./git-4f0fc4d5773b { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "lexxy: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else if version != null then
  throw "lexxy: no rubygems versions, only git revs: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
else
  throw "lexxy: specify git.rev — available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
