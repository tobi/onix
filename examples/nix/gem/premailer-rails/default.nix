#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# premailer-rails
#
# Versions: 1.11.0, 1.11.1, 1.12.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.12.0",
  git ? { },
}:
let
  versions = {
    "1.11.0" = import ./1.11.0 { inherit lib stdenv ruby; };
    "1.11.1" = import ./1.11.1 { inherit lib stdenv ruby; };
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "premailer-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "premailer-rails: unknown version '${version}'")
