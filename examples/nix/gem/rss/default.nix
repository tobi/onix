#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rss
#
# Versions: 0.2.9, 0.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.1",
  git ? { },
}:
let
  versions = {
    "0.2.9" = import ./0.2.9 { inherit lib stdenv ruby; };
    "0.3.1" = import ./0.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rss: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rss: unknown version '${version}'")
