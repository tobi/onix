#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pkg-config
#
# Versions: 1.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.6.3",
  git ? { },
}:
let
  versions = {
    "1.6.3" = import ./1.6.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "pkg-config: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "pkg-config: unknown version '${version}'")
