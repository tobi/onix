#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stimulus-rails
#
# Available versions:
#   1.3.4
#
# Usage:
#   stimulus-rails { version = "1.3.4"; }
#   stimulus-rails { }  # latest (1.3.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.3.4",
  git ? { },
}:
let
  versions = {
    "1.3.4" = import ./1.3.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stimulus-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "stimulus-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
