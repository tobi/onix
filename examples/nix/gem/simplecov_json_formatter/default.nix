#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simplecov_json_formatter
#
# Versions: 0.1.2, 0.1.3, 0.1.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.4",
  git ? { },
}:
let
  versions = {
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
    "0.1.3" = import ./0.1.3 { inherit lib stdenv ruby; };
    "0.1.4" = import ./0.1.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "simplecov_json_formatter: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "simplecov_json_formatter: unknown version '${version}'")
