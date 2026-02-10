#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest-retry
#
# Versions: 0.2.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.3",
  git ? { },
}:
let
  versions = {
    "0.2.3" = import ./0.2.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "minitest-retry: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "minitest-retry: unknown version '${version}'")
