#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# language_server-protocol
#
# Available versions:
#   3.17.0.5
#
# Usage:
#   language_server-protocol { version = "3.17.0.5"; }
#   language_server-protocol { }  # latest (3.17.0.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.17.0.5",
  git ? { },
}:
let
  versions = {
    "3.17.0.5" = import ./3.17.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "language_server-protocol: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "language_server-protocol: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
