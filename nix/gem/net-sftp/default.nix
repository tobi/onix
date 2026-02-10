#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-sftp
#
# Versions: 2.1.2, 3.0.0, 4.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.0.0",
  git ? { },
}:
let
  versions = {
    "2.1.2" = import ./2.1.2 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-sftp: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-sftp: unknown version '${version}'")
