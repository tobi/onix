#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws_cf_signer
#
# Versions: 0.1.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.3",
  git ? { },
}:
let
  versions = {
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "aws_cf_signer: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "aws_cf_signer: unknown version '${version}'")
