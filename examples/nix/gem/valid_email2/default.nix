#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# valid_email2
#
# Versions: 5.2.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.6",
  git ? { },
}:
let
  versions = {
    "5.2.6" = import ./5.2.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "valid_email2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "valid_email2: unknown version '${version}'")
