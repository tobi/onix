#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# toml-rb
#
# Versions: 3.0.1, 4.0.0, 4.1.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "4.1.0",
  git ? { },
}:
let
  versions = {
    "3.0.1" = import ./3.0.1 { inherit lib stdenv ruby; };
    "4.0.0" = import ./4.0.0 { inherit lib stdenv ruby; };
    "4.1.0" = import ./4.1.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "toml-rb: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "toml-rb: unknown version '${version}'")
