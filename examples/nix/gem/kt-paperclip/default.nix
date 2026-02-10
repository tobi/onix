#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kt-paperclip
#
# Versions: 7.3.0
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
    or (throw "kt-paperclip: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "kt-paperclip: unknown version '${version}'")
