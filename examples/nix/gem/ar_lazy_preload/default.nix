#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ar_lazy_preload
#
# Versions: 2.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.1",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ar_lazy_preload: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ar_lazy_preload: unknown version '${version}'")
