#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq-unique-jobs
#
# Versions: 7.1.33, 8.0.13
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.13",
  git ? { },
}:
let
  versions = {
    "7.1.33" = import ./7.1.33 { inherit lib stdenv ruby; };
    "8.0.13" = import ./8.0.13 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sidekiq-unique-jobs: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sidekiq-unique-jobs: unknown version '${version}'")
