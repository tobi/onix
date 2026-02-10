#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rake
#
# Versions: 13.2.1, 13.3.0, 13.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "13.3.1",
  git ? { },
}:
let
  versions = {
    "13.2.1" = import ./13.2.1 { inherit lib stdenv ruby; };
    "13.3.0" = import ./13.3.0 { inherit lib stdenv ruby; };
    "13.3.1" = import ./13.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rake: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rake: unknown version '${version}'")
