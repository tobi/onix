#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-sidekiq
#
# Versions: 5.0.0, 5.1.0, 5.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.2.0",
  git ? { },
}:
let
  versions = {
    "5.0.0" = import ./5.0.0 { inherit lib stdenv ruby; };
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
    "5.2.0" = import ./5.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-sidekiq: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-sidekiq: unknown version '${version}'")
