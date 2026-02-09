#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# retriable
#
# Available versions:
#   3.1.2
#
# Usage:
#   retriable { version = "3.1.2"; }
#   retriable { }  # latest (3.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.1.2",
  git ? { },
}:
let
  versions = {
    "3.1.2" = import ./3.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "retriable: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "retriable: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
