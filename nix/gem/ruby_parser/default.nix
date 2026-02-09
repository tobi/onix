#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_parser
#
# Available versions:
#   3.20.0
#
# Usage:
#   ruby_parser { version = "3.20.0"; }
#   ruby_parser { }  # latest (3.20.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.20.0",
  git ? { },
}:
let
  versions = {
    "3.20.0" = import ./3.20.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby_parser: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby_parser: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
