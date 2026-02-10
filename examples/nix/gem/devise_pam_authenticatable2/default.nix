#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# devise_pam_authenticatable2
#
# Versions: 9.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "9.2.0",
  git ? { },
}:
let
  versions = {
    "9.2.0" = import ./9.2.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "devise_pam_authenticatable2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "devise_pam_authenticatable2: unknown version '${version}'")
