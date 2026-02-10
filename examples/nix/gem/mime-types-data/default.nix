#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types-data
#
# Versions: 3.2023.0218.1, 3.2024.0305, 3.2025.0924, 3.2026.0113, 3.2026.0127, 3.2026.0203
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2026.0203",
  git ? { },
}:
let
  versions = {
    "3.2023.0218.1" = import ./3.2023.0218.1 { inherit lib stdenv ruby; };
    "3.2024.0305" = import ./3.2024.0305 { inherit lib stdenv ruby; };
    "3.2025.0924" = import ./3.2025.0924 { inherit lib stdenv ruby; };
    "3.2026.0113" = import ./3.2026.0113 { inherit lib stdenv ruby; };
    "3.2026.0127" = import ./3.2026.0127 { inherit lib stdenv ruby; };
    "3.2026.0203" = import ./3.2026.0203 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mime-types-data: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "mime-types-data: unknown version '${version}'")
