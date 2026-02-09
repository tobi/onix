#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sidekiq-cron
#
# Available versions:
#   1.12.0
#
# Usage:
#   sidekiq-cron { version = "1.12.0"; }
#   sidekiq-cron { }  # latest (1.12.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.12.0",
  git ? { },
}:
let
  versions = {
    "1.12.0" = import ./1.12.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "sidekiq-cron: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "sidekiq-cron: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
