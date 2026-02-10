#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sigv4
#
# Versions: 1.8.0, 1.11.0, 1.12.0, 1.12.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.12.1",
  git ? { },
}:
let
  versions = {
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
    "1.12.1" = import ./1.12.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sigv4: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sigv4: unknown version '${version}'")
