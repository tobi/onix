#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-ssh
#
# Versions: 7.2.1, 7.2.3, 7.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.3.0",
  git ? { },
}:
let
  versions = {
    "7.2.1" = import ./7.2.1 { inherit lib stdenv ruby; };
    "7.2.3" = import ./7.2.3 { inherit lib stdenv ruby; };
    "7.3.0" = import ./7.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-ssh: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-ssh: unknown version '${version}'")
