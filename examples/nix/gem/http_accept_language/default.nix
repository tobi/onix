#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http_accept_language
#
# Versions: 2.1.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.1.1",
  git ? { },
}:
let
  versions = {
    "2.1.1" = import ./2.1.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "http_accept_language: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "http_accept_language: unknown version '${version}'")
