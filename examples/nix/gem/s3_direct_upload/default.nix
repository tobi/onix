#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# s3_direct_upload
#
# Versions: 0.1.7
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.7",
  git ? { },
}:
let
  versions = {
    "0.1.7" = import ./0.1.7 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "s3_direct_upload: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "s3_direct_upload: unknown version '${version}'")
