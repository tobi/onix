#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-aliyun
#
# Versions: 0.3.18, 0.3.19, 0.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.0",
  git ? { },
}:
let
  versions = {
    "0.3.18" = import ./0.3.18 { inherit lib stdenv ruby; };
    "0.3.19" = import ./0.3.19 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fog-aliyun: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fog-aliyun: unknown version '${version}'")
