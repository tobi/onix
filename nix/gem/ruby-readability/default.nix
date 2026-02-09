#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-readability
#
# Available versions:
#   0.7.2
#
# Usage:
#   ruby-readability { version = "0.7.2"; }
#   ruby-readability { }  # latest (0.7.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.7.2",
  git ? { },
}:
let
  versions = {
    "0.7.2" = import ./0.7.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby-readability: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby-readability: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
