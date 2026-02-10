#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chef-config
#
# Versions: 18.8.54, 18.9.4, 19.1.164
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "19.1.164",
  git ? { },
}:
let
  versions = {
    "18.8.54" = import ./18.8.54 { inherit lib stdenv ruby; };
    "18.9.4" = import ./18.9.4 { inherit lib stdenv ruby; };
    "19.1.164" = import ./19.1.164 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "chef-config: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "chef-config: unknown version '${version}'")
