#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gitlab
#
# Versions: 5.1.0, 6.0.0, 6.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "6.1.0",
  git ? { },
}:
let
  versions = {
    "5.1.0" = import ./5.1.0 { inherit lib stdenv ruby; };
    "6.0.0" = import ./6.0.0 { inherit lib stdenv ruby; };
    "6.1.0" = import ./6.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gitlab: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gitlab: unknown version '${version}'")
