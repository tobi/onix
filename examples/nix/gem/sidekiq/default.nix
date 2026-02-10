#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq
#
# Versions: 6.5.12, 7.3.1, 7.3.9, 8.0.9, 8.0.10, 8.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.1.0",
  git ? { },
}:
let
  versions = {
    "6.5.12" = import ./6.5.12 { inherit lib stdenv ruby; };
    "7.3.1" = import ./7.3.1 { inherit lib stdenv ruby; };
    "7.3.9" = import ./7.3.9 { inherit lib stdenv ruby; };
    "8.0.9" = import ./8.0.9 { inherit lib stdenv ruby; };
    "8.0.10" = import ./8.0.10 { inherit lib stdenv ruby; };
    "8.1.0" = import ./8.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sidekiq: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sidekiq: unknown version '${version}'")
