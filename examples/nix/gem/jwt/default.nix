#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jwt
#
# Versions: 2.8.1, 2.10.1, 2.10.2, 3.1.0, 3.1.1, 3.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.2",
  git ? { },
}:
let
  versions = {
    "2.8.1" = import ./2.8.1 { inherit lib stdenv ruby; };
    "2.10.1" = import ./2.10.1 { inherit lib stdenv ruby; };
    "2.10.2" = import ./2.10.2 { inherit lib stdenv ruby; };
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.1.1" = import ./3.1.1 { inherit lib stdenv ruby; };
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jwt: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jwt: unknown version '${version}'")
