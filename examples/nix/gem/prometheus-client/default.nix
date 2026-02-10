#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prometheus-client
#
# Versions: 4.2.3, 4.2.4, 4.2.5
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.2.5",
  git ? { },
}:
let
  versions = {
    "4.2.3" = import ./4.2.3 { inherit lib stdenv ruby; };
    "4.2.4" = import ./4.2.4 { inherit lib stdenv ruby; };
    "4.2.5" = import ./4.2.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "prometheus-client: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "prometheus-client: unknown version '${version}'")
