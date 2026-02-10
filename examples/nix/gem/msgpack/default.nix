#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# msgpack
#
# Versions: 1.7.2, 1.7.4, 1.7.5, 1.8.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.0",
  git ? { },
}:
let
  versions = {
    "1.7.2" = import ./1.7.2 { inherit lib stdenv ruby; };
    "1.7.4" = import ./1.7.4 { inherit lib stdenv ruby; };
    "1.7.5" = import ./1.7.5 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "msgpack: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "msgpack: unknown version '${version}'")
