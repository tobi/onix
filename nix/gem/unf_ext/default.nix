#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unf_ext
#
# Available versions:
#   0.0.8.2
#
# Usage:
#   unf_ext { version = "0.0.8.2"; }
#   unf_ext { }  # latest (0.0.8.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.8.2",
  git ? { },
}:
let
  versions = {
    "0.0.8.2" = import ./0.0.8.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "unf_ext: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "unf_ext: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
