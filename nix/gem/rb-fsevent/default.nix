#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb-fsevent
#
# Available versions:
#   0.11.2
#
# Usage:
#   rb-fsevent { version = "0.11.2"; }
#   rb-fsevent { }  # latest (0.11.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.11.2",
  git ? { },
}:
let
  versions = {
    "0.11.2" = import ./0.11.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb-fsevent: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rb-fsevent: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
