#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zendesk_api
#
# Available versions:
#   1.38.0.rc1
#
# Usage:
#   zendesk_api { version = "1.38.0.rc1"; }
#   zendesk_api { }  # latest (1.38.0.rc1)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.38.0.rc1",
  git ? { },
}:
let
  versions = {
    "1.38.0.rc1" = import ./1.38.0.rc1 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "zendesk_api: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "zendesk_api: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
