#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jquery-ui-rails
#
# Versions: 6.0.1, 7.0.0, 8.0.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "8.0.0",
  git ? { },
}:
let
  versions = {
    "6.0.1" = import ./6.0.1 { inherit lib stdenv ruby; };
    "7.0.0" = import ./7.0.0 { inherit lib stdenv ruby; };
    "8.0.0" = import ./8.0.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "jquery-ui-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "jquery-ui-rails: unknown version '${version}'")
