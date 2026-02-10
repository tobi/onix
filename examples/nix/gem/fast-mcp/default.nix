#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fast-mcp
#
# Versions: 1.5.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.5.0",
  git ? { },
}:
let
  versions = {
    "1.5.0" = import ./1.5.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fast-mcp: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fast-mcp: unknown version '${version}'")
