#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# request_store
#
# Versions: 1.5.1, 1.6.0, 1.7.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.7.0",
  git ? { },
}:
let
  versions = {
    "1.5.1" = import ./1.5.1 { inherit lib stdenv ruby; };
    "1.6.0" = import ./1.6.0 { inherit lib stdenv ruby; };
    "1.7.0" = import ./1.7.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "request_store: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "request_store: unknown version '${version}'")
