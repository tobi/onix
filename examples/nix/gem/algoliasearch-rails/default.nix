#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# algoliasearch-rails
#
# Versions: 2.3.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.3.2",
  git ? { },
}:
let
  versions = {
    "2.3.2" = import ./2.3.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "algoliasearch-rails: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "algoliasearch-rails: unknown version '${version}'")
