#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# derailed_benchmarks
#
# Versions: 2.1.2, 2.2.0, 2.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.1",
  git ? { },
}:
let
  versions = {
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "2.2.0" = import ./2.2.0 { inherit lib stdenv ruby; };
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "derailed_benchmarks: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "derailed_benchmarks: unknown version '${version}'")
