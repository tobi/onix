#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# connection_pool
#
# Versions: 2.4.1, 2.5.3, 2.5.4, 2.5.5, 3.0.0, 3.0.1, 3.0.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.0.2",
  git ? { },
}:
let
  versions = {
    "2.4.1" = import ./2.4.1 { inherit lib stdenv ruby; };
    "2.5.3" = import ./2.5.3 { inherit lib stdenv ruby; };
    "2.5.4" = import ./2.5.4 { inherit lib stdenv ruby; };
    "2.5.5" = import ./2.5.5 { inherit lib stdenv ruby; };
    "3.0.0" = import ./3.0.0 { inherit lib stdenv ruby; };
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "3.0.2" = import ./3.0.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "connection_pool: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "connection_pool: unknown version '${version}'")
