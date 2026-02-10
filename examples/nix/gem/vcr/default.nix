#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vcr
#
# Versions: 6.3.0, 6.3.1, 6.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.4.0",
  git ? { },
}:
let
  versions = {
    "6.3.0" = import ./6.3.0 { inherit lib stdenv ruby; };
    "6.3.1" = import ./6.3.1 { inherit lib stdenv ruby; };
    "6.4.0" = import ./6.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vcr: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "vcr: unknown version '${version}'")
