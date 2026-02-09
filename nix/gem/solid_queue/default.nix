#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_queue
#
# Available versions:
#   1.2.4
#
# Usage:
#   solid_queue { version = "1.2.4"; }
#   solid_queue { }  # latest (1.2.4)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2.4",
  git ? { },
}:
let
  versions = {
    "1.2.4" = import ./1.2.4 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "solid_queue: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "solid_queue: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
