#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-session
#
# Versions: 1.0.2, 2.0.0, 2.1.0, 2.1.1
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
    "1.0.2" = import ./1.0.2 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
    "2.1.0" = import ./2.1.0 { inherit lib stdenv ruby; };
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rack-session: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rack-session: unknown version '${version}'")
