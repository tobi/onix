#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email_spec
#
# Versions: 2.2.1, 2.2.2, 2.3.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.0",
  git ? { },
}:
let
  versions = {
    "2.2.1" = import ./2.2.1 { inherit lib stdenv ruby; };
    "2.2.2" = import ./2.2.2 { inherit lib stdenv ruby; };
    "2.3.0" = import ./2.3.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "email_spec: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "email_spec: unknown version '${version}'")
