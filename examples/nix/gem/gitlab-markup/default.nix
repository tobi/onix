#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gitlab-markup
#
# Versions: 1.9.0, 1.10.0, 2.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.0",
  git ? { },
}:
let
  versions = {
    "1.9.0" = import ./1.9.0 { inherit lib stdenv ruby; };
    "1.10.0" = import ./1.10.0 { inherit lib stdenv ruby; };
    "2.0.0" = import ./2.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "gitlab-markup: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "gitlab-markup: unknown version '${version}'")
