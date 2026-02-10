#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-net_http
#
# Versions: 3.1.0, 3.4.0, 3.4.1, 3.4.2
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.2",
  git ? { },
}:
let
  versions = {
    "3.1.0" = import ./3.1.0 { inherit lib stdenv ruby; };
    "3.4.0" = import ./3.4.0 { inherit lib stdenv ruby; };
    "3.4.1" = import ./3.4.1 { inherit lib stdenv ruby; };
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "faraday-net_http: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "faraday-net_http: unknown version '${version}'")
