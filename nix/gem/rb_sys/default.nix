#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rb_sys
#
# Available versions:
#   0.9.119
#
# Usage:
#   rb_sys { version = "0.9.119"; }
#   rb_sys { }  # latest (0.9.119)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.9.119",
  git ? { },
}:
let
  versions = {
    "0.9.119" = import ./0.9.119 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "rb_sys: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "rb_sys: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
