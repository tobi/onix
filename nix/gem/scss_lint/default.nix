#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# scss_lint
#
# Available versions:
#   0.60.0
#
# Usage:
#   scss_lint { version = "0.60.0"; }
#   scss_lint { }  # latest (0.60.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.60.0",
  git ? { },
}:
let
  versions = {
    "0.60.0" = import ./0.60.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "scss_lint: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "scss_lint: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
