#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email_validator
#
# Versions: 2.2.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.2.4",
  git ? { },
}:
let
  versions = {
    "2.2.4" = import ./2.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "email_validator: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "email_validator: unknown version '${version}'")
