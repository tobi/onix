#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-next-core
#
# Versions: 0.15.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.15.2",
  git ? { },
}:
let
  versions = {
    "0.15.2" = import ./0.15.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-next-core: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-next-core: unknown version '${version}'")
