#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wkhtmltopdf-binary
#
# Versions: 0.12.6.8, 0.12.6.9, 0.12.6.10
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.12.6.10",
  git ? { },
}:
let
  versions = {
    "0.12.6.8" = import ./0.12.6.8 { inherit lib stdenv ruby; };
    "0.12.6.9" = import ./0.12.6.9 { inherit lib stdenv ruby; };
    "0.12.6.10" = import ./0.12.6.10 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "wkhtmltopdf-binary: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "wkhtmltopdf-binary: unknown version '${version}'")
