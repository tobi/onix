#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_invitable
#
# Versions: 2.0.9
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.0.9",
  git ? { },
}:
let
  versions = {
    "2.0.9" = import ./2.0.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise_invitable: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "devise_invitable: unknown version '${version}'")
