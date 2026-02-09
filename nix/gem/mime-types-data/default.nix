#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types-data
#
# Available versions:
#   3.2023.0218.1
#   3.2025.0924
#
# Usage:
#   mime-types-data { version = "3.2025.0924"; }
#   mime-types-data { }  # latest (3.2025.0924)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "3.2025.0924",
  git ? { },
}:
let
  versions = {
    "3.2023.0218.1" = import ./3.2023.0218.1 { inherit lib stdenv ruby; };
    "3.2025.0924" = import ./3.2025.0924 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "mime-types-data: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "mime-types-data: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
