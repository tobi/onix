#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# doorkeeper-i18n
#
# Versions: 5.2.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.8",
  git ? { },
}:
let
  versions = {
    "5.2.8" = import ./5.2.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "doorkeeper-i18n: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "doorkeeper-i18n: unknown version '${version}'")
