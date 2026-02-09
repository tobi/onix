#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# regexp_parser
#
# Available versions:
#   2.10.0
#   2.11.3
#
# Usage:
#   regexp_parser { version = "2.11.3"; }
#   regexp_parser { }  # latest (2.11.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "2.11.3",
  git ? { },
}:
let
  versions = {
    "2.10.0" = import ./2.10.0 { inherit lib stdenv ruby; };
    "2.11.3" = import ./2.11.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "regexp_parser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "regexp_parser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
