#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http2
#
# Versions: 0.18.4
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.18.4",
  git ? { },
}:
let
  versions = {
    "0.18.4" = import ./0.18.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "net-http2: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "net-http2: unknown version '${version}'")
