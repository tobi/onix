#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webmock
#
# Available versions:
#   3.23.1
#   3.25.1
#   3.26.1
#
# Usage:
#   webmock { version = "3.26.1"; }
#   webmock { }  # latest (3.26.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.26.1",
  git ? { },
}:
let
  versions = {
    "3.23.1" = import ./3.23.1 { inherit lib stdenv ruby; };
    "3.25.1" = import ./3.25.1 { inherit lib stdenv ruby; };
    "3.26.1" = import ./3.26.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webmock: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "webmock: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
