#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tpm-key_attestation
#
# Versions: 0.14.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.14.1",
  git ? { },
}:
let
  versions = {
    "0.14.1" = import ./0.14.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tpm-key_attestation: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tpm-key_attestation: unknown version '${version}'")
