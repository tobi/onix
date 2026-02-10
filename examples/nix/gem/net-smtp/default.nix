#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-smtp
#
# Versions: 0.3.4, 0.4.0.1, 0.5.0, 0.5.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.1",
  git ? { },
}:
let
  versions = {
    "0.3.4" = import ./0.3.4 { inherit lib stdenv ruby; };
    "0.4.0.1" = import ./0.4.0.1 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
    "0.5.1" = import ./0.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-smtp: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-smtp: unknown version '${version}'")
