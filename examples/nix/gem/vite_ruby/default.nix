#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vite_ruby
#
# Versions: 3.8.0, 3.9.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.9.2",
  git ? { },
}:
let
  versions = {
    "3.8.0" = import ./3.8.0 { inherit lib stdenv ruby; };
    "3.9.2" = import ./3.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "vite_ruby: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "vite_ruby: unknown version '${version}'")
