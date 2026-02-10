#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# liquid-spec (git only)
#
# Available git revs:
#   9d6fa8fb4e4a
#
# Usage:
#   liquid-spec { git.rev = "9d6fa8fb4e4a"; }
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
    "9d6fa8fb4e4a" = import ./git-9d6fa8fb4e4a { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "liquid-spec: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else if version != null then
  throw "liquid-spec: no rubygems versions, only git revs: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
else
  throw "liquid-spec: specify git.rev — available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
