#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faker
#
# Versions: 3.2.0, 3.5.1, 3.5.2, 3.5.3, 3.6.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.6.0",
  git ? { },
}:
let
  versions = {
    "3.2.0" = import ./3.2.0 { inherit lib stdenv ruby; };
    "3.5.1" = import ./3.5.1 { inherit lib stdenv ruby; };
    "3.5.2" = import ./3.5.2 { inherit lib stdenv ruby; };
    "3.5.3" = import ./3.5.3 { inherit lib stdenv ruby; };
    "3.6.0" = import ./3.6.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faker: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faker: unknown version '${version}'")
