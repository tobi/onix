#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# administrate-field-active_storage
#
# Available versions:
#   1.0.3
#
# Usage:
#   administrate-field-active_storage { version = "1.0.3"; }
#   administrate-field-active_storage { }  # latest (1.0.3)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.0.3",
  git ? { },
}:
let
  versions = {
    "1.0.3" = import ./1.0.3 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "administrate-field-active_storage: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "administrate-field-active_storage: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
