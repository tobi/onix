#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webrick
#
# Versions: 1.8.2, 1.9.0, 1.9.1, 1.9.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.2",
  git ? { },
}:
let
  versions = {
    "1.8.2" = import ./1.8.2 { inherit lib stdenv ruby; };
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.9.1" = import ./1.9.1 { inherit lib stdenv ruby; };
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webrick: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "webrick: unknown version '${version}'")
