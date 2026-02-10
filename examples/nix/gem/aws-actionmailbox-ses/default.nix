#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-actionmailbox-ses
#
# Versions: 0.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.0",
  git ? { },
}:
let
  versions = {
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-actionmailbox-ses: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-actionmailbox-ses: unknown version '${version}'")
