#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_record_query_trace
#
# Versions: 1.8
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8",
  git ? { },
}:
let
  versions = {
    "1.8" = import ./1.8 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "active_record_query_trace: unknown git rev '${git.rev}'")
else
  versions.${version}
    or (throw "active_record_query_trace: unknown version '${version}'")
