#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thread_safe
#
# Versions: 0.3.4, 0.3.5, 0.3.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.3.6",
  git ? { },
}:
let
  versions = {
    "0.3.4" = import ./0.3.4 { inherit lib stdenv ruby; };
    "0.3.5" = import ./0.3.5 { inherit lib stdenv ruby; };
    "0.3.6" = import ./0.3.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "thread_safe: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "thread_safe: unknown version '${version}'")
