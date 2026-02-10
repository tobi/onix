#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_math_bundle
#
# Versions: 1.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.1",
  git ? { },
}:
let
  versions = {
    "1.0.1" = import ./1.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "discourse_math_bundle: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "discourse_math_bundle: unknown version '${version}'")
