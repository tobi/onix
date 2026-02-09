#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webrick
#
# Available versions:
#   1.9.2
#
# Usage:
#   webrick { version = "1.9.2"; }
#   webrick { }  # latest (1.9.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.9.2",
  git ? { },
}:
let
  versions = {
    "1.9.2" = import ./1.9.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "webrick: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "webrick: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
