#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# terminal-notifier
#
# Versions: 1.7.2, 1.8.0, 2.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0",
  git ? { },
}:
let
  versions = {
    "1.7.2" = import ./1.7.2 { inherit lib stdenv ruby; };
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "terminal-notifier: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "terminal-notifier: unknown version '${version}'")
