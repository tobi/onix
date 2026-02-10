#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nanaimo
#
# Versions: 0.2.6, 0.3.0, 0.4.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.0",
  git ? { },
}:
let
  versions = {
    "0.2.6" = import ./0.2.6 { inherit lib stdenv ruby; };
    "0.3.0" = import ./0.3.0 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "nanaimo: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "nanaimo: unknown version '${version}'")
