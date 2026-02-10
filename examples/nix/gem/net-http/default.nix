#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http
#
# Versions: 0.4.1, 0.6.0, 0.8.0, 0.9.0, 0.9.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.1",
  git ? { },
}:
let
  versions = {
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
    "0.6.0" = import ./0.6.0 { inherit lib stdenv ruby; };
    "0.8.0" = import ./0.8.0 { inherit lib stdenv ruby; };
    "0.9.0" = import ./0.9.0 { inherit lib stdenv ruby; };
    "0.9.1" = import ./0.9.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-http: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-http: unknown version '${version}'")
