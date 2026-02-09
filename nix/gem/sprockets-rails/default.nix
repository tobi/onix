#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sprockets-rails
#
# Available versions:
#   3.4.2
#
# Usage:
#   sprockets-rails { version = "3.4.2"; }
#   sprockets-rails { }  # latest (3.4.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.4.2",
  git ? { },
}:
let
  versions = {
    "3.4.2" = import ./3.4.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sprockets-rails: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sprockets-rails: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
