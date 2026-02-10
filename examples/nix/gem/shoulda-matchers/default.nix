#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shoulda-matchers
#
# Versions: 5.3.0, 6.4.0, 6.5.0, 7.0.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.0.1",
  git ? { },
}:
let
  versions = {
    "5.3.0" = import ./5.3.0 { inherit lib stdenv ruby; };
    "6.4.0" = import ./6.4.0 { inherit lib stdenv ruby; };
    "6.5.0" = import ./6.5.0 { inherit lib stdenv ruby; };
    "7.0.1" = import ./7.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "shoulda-matchers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "shoulda-matchers: unknown version '${version}'")
