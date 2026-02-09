#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uniform_notifier
#
# Available versions:
#   1.17.0
#   1.18.0
#
# Usage:
#   uniform_notifier { version = "1.18.0"; }
#   uniform_notifier { }  # latest (1.18.0)
#
{
  lib,
  stdenv,
  ruby,
  pkgs ? null,
  version ? "1.18.0",
  git ? { },
}:
let
  versions = {
    "1.17.0" = import ./1.17.0 { inherit lib stdenv ruby; };
    "1.18.0" = import ./1.18.0 { inherit lib stdenv ruby; };
  };

  gitRevs = {
  };
in
if git ? rev then
  gitRevs.${git.rev}
    or (throw "uniform_notifier: unknown git rev '${git.rev}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames gitRevs)}")
else
  versions.${version}
    or (throw "uniform_notifier: unknown version '${version}'. Available: ${builtins.concatStringsSep ", " (builtins.attrNames versions)}")
