#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-saml
#
# Versions: 1.17.0, 1.18.0, 1.18.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.18.1",
  git ? { },
}:
let
  versions = {
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
    "1.18.0" = import ./1.18.0 { inherit lib stdenv ruby; };
    "1.18.1" = import ./1.18.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-saml: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "ruby-saml: unknown version '${version}'")
