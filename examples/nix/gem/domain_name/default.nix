#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# domain_name
#
# Versions: 0.5.20190701, 0.6.20231109, 0.6.20240107
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.6.20240107",
  git ? { },
}:
let
  versions = {
    "0.5.20190701" = import ./0.5.20190701 { inherit lib stdenv ruby; };
    "0.6.20231109" = import ./0.6.20231109 { inherit lib stdenv ruby; };
    "0.6.20240107" = import ./0.6.20240107 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "domain_name: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "domain_name: unknown version '${version}'")
