#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-saml
#
# Versions: 2.2.2, 2.2.3, 2.2.4
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
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
    "2.2.3" = import ./2.2.3 { inherit lib stdenv ruby; };
    "2.2.4" = import ./2.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "omniauth-saml: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "omniauth-saml: unknown version '${version}'")
