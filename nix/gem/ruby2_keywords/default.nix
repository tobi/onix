#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby2_keywords
#
# Available versions:
#   0.0.5
#
# Usage:
#   ruby2_keywords { version = "0.0.5"; }
#   ruby2_keywords { }  # latest (0.0.5)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.5",
  git ? { },
}:
let
  versions = {
    "0.0.5" = import ./0.0.5 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "ruby2_keywords: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "ruby2_keywords: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
