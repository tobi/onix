#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-kinesis-aggregation
#
# Versions: 0.3.4, 0.4.0, 0.4.1
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.4.1",
  git ? { },
}:
let
  versions = {
    "0.3.4" = import ./0.3.4 { inherit lib stdenv ruby; };
    "0.4.0" = import ./0.4.0 { inherit lib stdenv ruby; };
    "0.4.1" = import ./0.4.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "fluent-plugin-kinesis-aggregation: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "fluent-plugin-kinesis-aggregation: unknown version '${version}'")
