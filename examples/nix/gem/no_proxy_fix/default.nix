#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# no_proxy_fix
#
# Versions: 0.1.0, 0.1.1, 0.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.2",
  git ? { },
}:
let
  versions = {
    "0.1.0" = import ./0.1.0 { inherit lib stdenv ruby; };
    "0.1.1" = import ./0.1.1 { inherit lib stdenv ruby; };
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "no_proxy_fix: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "no_proxy_fix: unknown version '${version}'")
