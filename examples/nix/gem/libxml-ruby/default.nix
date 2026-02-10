#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libxml-ruby
#
# Versions: 5.0.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "5.0.4",
  git ? { },
}:
let
  versions = {
    "5.0.4" = import ./5.0.4 { inherit lib stdenv ruby pkgs; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "libxml-ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "libxml-ruby: unknown version '${version}'")
