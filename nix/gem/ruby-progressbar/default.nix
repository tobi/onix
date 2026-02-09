#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-progressbar
#
# Available versions:
#   1.13.0
#
# Usage:
#   ruby-progressbar { version = "1.13.0"; }
#   ruby-progressbar { }  # latest (1.13.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.13.0",
  git ? { },
}:
let
  versions = {
    "1.13.0" = import ./1.13.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-progressbar: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-progressbar: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
