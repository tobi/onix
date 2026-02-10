#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twitter-text
#
# Versions: 3.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.0",
  git ? { },
}:
let
  versions = {
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "twitter-text: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "twitter-text: unknown version '${version}'")
