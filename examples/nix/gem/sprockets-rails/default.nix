#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sprockets-rails
#
# Versions: 3.4.2, 3.5.0, 3.5.1, 3.5.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.5.2",
  git ? { },
}:
let
  versions = {
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
    "3.5.0" = import ./3.5.0 { inherit lib stdenv ruby; };
    "3.5.1" = import ./3.5.1 { inherit lib stdenv ruby; };
    "3.5.2" = import ./3.5.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sprockets-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "sprockets-rails: unknown version '${version}'")
