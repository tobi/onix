#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parser
#
# Versions: 3.3.1.0, 3.3.8.0, 3.3.9.0, 3.3.10.0, 3.3.10.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.3.10.1",
  git ? { },
}:
let
  versions = {
    "3.3.1.0" = import ./3.3.1.0 { inherit lib stdenv ruby; };
    "3.3.8.0" = import ./3.3.8.0 { inherit lib stdenv ruby; };
    "3.3.9.0" = import ./3.3.9.0 { inherit lib stdenv ruby; };
    "3.3.10.0" = import ./3.3.10.0 { inherit lib stdenv ruby; };
    "3.3.10.1" = import ./3.3.10.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "parser: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "parser: unknown version '${version}'")
