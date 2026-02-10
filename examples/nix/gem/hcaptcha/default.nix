#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# hcaptcha
#
# Versions: 7.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.1.0",
  git ? { },
}:
let
  versions = {
    "7.1.0" = import ./7.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "hcaptcha: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "hcaptcha: unknown version '${version}'")
