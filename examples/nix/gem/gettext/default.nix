#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gettext
#
# Versions: 3.4.9, 3.5.0, 3.5.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.1",
  git ? { },
}:
let
  versions = {
    "3.4.9" = import ./3.4.9 { inherit lib stdenv ruby; };
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
    "3.5.1" = import ./3.5.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gettext: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gettext: unknown version '${version}'")
