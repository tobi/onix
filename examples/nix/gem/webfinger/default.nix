#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webfinger
#
# Versions: 2.1.1, 2.1.2, 2.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.3",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.1.3" = import ./2.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webfinger: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webfinger: unknown version '${version}'")
