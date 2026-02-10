#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tokenizers
#
# Versions: 0.6.3
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.3",
  git ? { },
}:
let
  versions = {
    "0.6.3" = import ./0.6.3 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tokenizers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "tokenizers: unknown version '${version}'")
