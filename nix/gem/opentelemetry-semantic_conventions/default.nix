#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-semantic_conventions
#
# Versions: 1.36.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.36.0",
  git ? { },
}:
let
  versions = {
    "1.36.0" = import ./1.36.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "opentelemetry-semantic_conventions: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "opentelemetry-semantic_conventions: unknown version '${version}'")
