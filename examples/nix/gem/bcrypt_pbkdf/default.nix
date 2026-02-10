#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bcrypt_pbkdf
#
# Versions: 1.1.0, 1.1.1, 1.1.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.1.2",
  git ? { },
}:
let
  versions = {
    "1.1.0" = import ./1.1.0 { inherit lib stdenv ruby; };
    "1.1.1" = import ./1.1.1 { inherit lib stdenv ruby; };
    "1.1.2" = import ./1.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "bcrypt_pbkdf: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "bcrypt_pbkdf: unknown version '${version}'")
