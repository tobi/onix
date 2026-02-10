#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonpath
#
# Versions: 1.1.3, 1.1.4, 1.1.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.5",
  git ? { },
}:
let
  versions = {
    "1.1.3" = import ./1.1.3 { inherit lib stdenv ruby; };
    "1.1.4" = import ./1.1.4 { inherit lib stdenv ruby; };
    "1.1.5" = import ./1.1.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jsonpath: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jsonpath: unknown version '${version}'")
