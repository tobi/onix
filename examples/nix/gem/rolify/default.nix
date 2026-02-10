#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rolify
#
# Versions: 6.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.0.1",
  git ? { },
}:
let
  versions = {
    "6.0.1" = import ./6.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rolify: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rolify: unknown version '${version}'")
