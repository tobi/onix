#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uniform_notifier
#
# Versions: 1.16.0, 1.17.0, 1.18.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.18.0",
  git ? { },
}:
let
  versions = {
    "1.16.0" = import ./1.16.0 { inherit lib stdenv ruby; };
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
    "1.18.0" = import ./1.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "uniform_notifier: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "uniform_notifier: unknown version '${version}'")
