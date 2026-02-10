#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# line-bot-api
#
# Versions: 1.28.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.28.0",
  git ? { },
}:
let
  versions = {
    "1.28.0" = import ./1.28.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "line-bot-api: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "line-bot-api: unknown version '${version}'")
