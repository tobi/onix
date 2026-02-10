#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth2
#
# Versions: 1.4.11, 2.0.9, 2.0.16, 2.0.17, 2.0.18
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.18",
  git ? { },
}:
let
  versions = {
    "1.4.11" = import ./1.4.11 { inherit lib stdenv ruby; };
    "2.0.9" = import ./2.0.9 { inherit lib stdenv ruby; };
    "2.0.16" = import ./2.0.16 { inherit lib stdenv ruby; };
    "2.0.17" = import ./2.0.17 { inherit lib stdenv ruby; };
    "2.0.18" = import ./2.0.18 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "oauth2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "oauth2: unknown version '${version}'")
