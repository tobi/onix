#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stripe
#
# Available versions:
#   11.1.0
#   18.0.1
#
# Usage:
#   stripe { version = "18.0.1"; }
#   stripe { }  # latest (18.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "18.0.1",
  git ? { },
}:
let
  versions = {
    "11.1.0" = import ./11.1.0 { inherit lib stdenv ruby; };
    "18.0.1" = import ./18.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "stripe: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "stripe: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
