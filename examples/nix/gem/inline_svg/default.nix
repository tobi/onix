#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# inline_svg
#
# Versions: 1.9.0, 1.10.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.10.0",
  git ? { },
}:
let
  versions = {
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "inline_svg: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "inline_svg: unknown version '${version}'")
