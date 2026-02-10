#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# action_text-trix
#
# Versions: 2.1.16
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.16",
  git ? { },
}:
let
  versions = {
    "2.1.16" = import ./2.1.16 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "action_text-trix: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "action_text-trix: unknown version '${version}'")
