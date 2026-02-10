#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# atlassian-jwt
#
# Versions: 0.1.1, 0.2.0, 0.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.2.1",
  git ? { },
}:
let
  versions = {
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
    "0.2.0" = import ./0.2.0 { inherit lib stdenv ruby; };
    "0.2.1" = import ./0.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "atlassian-jwt: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "atlassian-jwt: unknown version '${version}'")
