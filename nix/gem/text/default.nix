#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# text
#
# Versions: 1.2.3, 1.3.0, 1.3.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.1",
  git ? { },
}:
let
  versions = {
    "1.2.3" = import ./1.2.3 { inherit lib stdenv ruby; };
    "1.3.0" = import ./1.3.0 { inherit lib stdenv ruby; };
    "1.3.1" = import ./1.3.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "text: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "text: unknown version '${version}'")
