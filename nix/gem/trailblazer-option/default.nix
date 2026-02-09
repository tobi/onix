#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# trailblazer-option
#
# Available versions:
#   0.1.2
#
# Usage:
#   trailblazer-option { version = "0.1.2"; }
#   trailblazer-option { }  # latest (0.1.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.1.2",
  git ? { },
}:
let
  versions = {
    "0.1.2" = import ./0.1.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "trailblazer-option: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "trailblazer-option: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
