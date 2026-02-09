#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# msgpack
#
# Available versions:
#   1.8.0
#
# Usage:
#   msgpack { version = "1.8.0"; }
#   msgpack { }  # latest (1.8.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.8.0",
  git ? { },
}:
let
  versions = {
    "1.8.0" = import ./1.8.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "msgpack: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "msgpack: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
