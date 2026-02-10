#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-collection_matchers
#
# Versions: 1.1.3, 1.2.0, 1.2.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.1",
  git ? { },
}:
let
  versions = {
    "1.1.3" = import ./1.1.3 { inherit lib stdenv ruby; };
    "1.2.0" = import ./1.2.0 { inherit lib stdenv ruby; };
    "1.2.1" = import ./1.2.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rspec-collection_matchers: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "rspec-collection_matchers: unknown version '${version}'")
