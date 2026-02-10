#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-ole
#
# Versions: 1.2.12.2, 1.2.13, 1.2.13.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.13.1",
  git ? { },
}:
let
  versions = {
    "1.2.12.2" = import ./1.2.12.2 { inherit lib stdenv ruby; };
    "1.2.13" = import ./1.2.13 { inherit lib stdenv ruby; };
    "1.2.13.1" = import ./1.2.13.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-ole: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-ole: unknown version '${version}'")
