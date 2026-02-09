#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tzinfo-data
#
# Available versions:
#   1.2023.3
#   1.2025.2
#
# Usage:
#   tzinfo-data { version = "1.2025.2"; }
#   tzinfo-data { }  # latest (1.2025.2)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.2025.2",
  git ? { },
}:
let
  versions = {
    "1.2023.3" = import ./1.2023.3 { inherit lib stdenv ruby; };
    "1.2025.2" = import ./1.2025.2 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "tzinfo-data: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "tzinfo-data: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
