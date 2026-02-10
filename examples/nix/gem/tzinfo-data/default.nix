#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tzinfo-data
#
# Versions: 1.2023.3, 1.2025.1, 1.2025.2, 1.2025.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2025.3",
  git ? { },
}:
let
  versions = {
    "1.2023.3" = import ./1.2023.3 { inherit lib stdenv ruby; };
    "1.2025.1" = import ./1.2025.1 { inherit lib stdenv ruby; };
    "1.2025.2" = import ./1.2025.2 { inherit lib stdenv ruby; };
    "1.2025.3" = import ./1.2025.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tzinfo-data: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tzinfo-data: unknown version '${version}'")
