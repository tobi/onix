#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cgi
#
# Versions: 0.3.6, 0.4.2, 0.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.5.0",
  git ? { },
}:
let
  versions = {
    "0.3.6" = import ./0.3.6 { inherit lib stdenv ruby; };
    "0.4.2" = import ./0.4.2 { inherit lib stdenv ruby; };
    "0.5.0" = import ./0.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "cgi: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "cgi: unknown version '${version}'")
