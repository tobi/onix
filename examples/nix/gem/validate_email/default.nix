#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validate_email
#
# Versions: 0.1.6
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.6",
  git ? { },
}:
let
  versions = {
    "0.1.6" = import ./0.1.6 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "validate_email: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "validate_email: unknown version '${version}'")
