#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluentd
#
# Versions: 1.18.0, 1.19.0, 1.19.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.19.1",
  git ? { },
}:
let
  versions = {
    "1.18.0" = import ./1.18.0 { inherit lib stdenv ruby; };
    "1.19.0" = import ./1.19.0 { inherit lib stdenv ruby; };
    "1.19.1" = import ./1.19.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluentd: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fluentd: unknown version '${version}'")
