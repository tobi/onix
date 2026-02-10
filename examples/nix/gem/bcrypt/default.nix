#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bcrypt
#
# Versions: 3.1.19, 3.1.20, 3.1.21
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.21",
  git ? { },
}:
let
  versions = {
    "3.1.19" = import ./3.1.19 { inherit lib stdenv ruby; };
    "3.1.20" = import ./3.1.20 { inherit lib stdenv ruby; };
    "3.1.21" = import ./3.1.21 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bcrypt: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bcrypt: unknown version '${version}'")
