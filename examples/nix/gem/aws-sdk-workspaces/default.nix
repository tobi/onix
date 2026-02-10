#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-workspaces
#
# Versions: 1.151.0, 1.152.0, 1.153.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.153.0",
  git ? { },
}:
let
  versions = {
    "1.151.0" = import ./1.151.0 { inherit lib stdenv ruby; };
    "1.152.0" = import ./1.152.0 { inherit lib stdenv ruby; };
    "1.153.0" = import ./1.153.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws-sdk-workspaces: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws-sdk-workspaces: unknown version '${version}'")
