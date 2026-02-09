#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_record_query_trace
#
# Available versions:
#   1.8
#
# Usage:
#   active_record_query_trace { version = "1.8"; }
#   active_record_query_trace { }  # latest (1.8)
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
    or (throw "active_record_query_trace: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "active_record_query_trace: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
