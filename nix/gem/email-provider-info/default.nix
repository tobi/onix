#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email-provider-info
#
# Available versions:
#   0.0.1
#
# Usage:
#   email-provider-info { version = "0.0.1"; }
#   email-provider-info { }  # latest (0.0.1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "0.0.1",
  git ? { },
}:
let
  versions = {
    "0.0.1" = import ./0.0.1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "email-provider-info: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "email-provider-info: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
