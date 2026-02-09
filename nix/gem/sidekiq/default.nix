#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq
#
# Available versions:
#   7.3.1
#   7.3.9
#
# Usage:
#   sidekiq { version = "7.3.9"; }
#   sidekiq { }  # latest (7.3.9)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "7.3.9",
  git ? { },
}:
let
  versions = {
    "7.3.1" = import ./7.3.1 { inherit lib stdenv ruby; };
    "7.3.9" = import ./7.3.9 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sidekiq: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sidekiq: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
