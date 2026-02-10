#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# acts_as_follower (git only)
#
# Available git revs:
#   06393d3693a1
#
# Usage:
#   acts_as_follower { git.rev = "06393d3693a1"; }
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
    "06393d3693a1" = import ./git-06393d3693a1 { inherit lib stdenv ruby; };
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "acts_as_follower: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else if version != null then
  throw "acts_as_follower: no rubygems versions, only git revs: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
else
  throw "acts_as_follower: specify git.rev — available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}"
